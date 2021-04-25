import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def preencher_vertical(perfil, profs, tam):
	#Interpola as profundidades para encontrar valores faltantes

	# Une o perfil de velocidade a cada profundidade
    conj = list(zip(perfil, profs))
    expandido = np.zeros(tam)

    for idx, par in enumerate(conj):
		#Ex conj: [(v1,p1), (v2,p2), (v3,p3)]
		#Para cada elemento de conj temos um indice 0,1,2... e um par (v1,p1), (v2,p2)...
        vel = par[0]
        prof = par[1]

		#Registramos a velocidade conhecida na profundidade conhecida
        expandido[prof] = vel

		#Se houver profundidades depois para serem interpoladas
        if prof < tam - 1:
        	#prox = próximo par (v,p) da lista conj
            prox = conj[idx + 1]
            	# Coeficiente angular
            m = (prox[0] - vel) / (prox[1] - prof)

		#Profundidades faltantes entre o ponto atual e o próximo
		#Ex: atual = 10m, próximo 15m, faltantes = [11, 11, 13, 14]
            faltantes = list(range(prof, prox[1]))[1:]

            for f in faltantes:
		#Aplicar equacao pros pontos faltantes
                expandido[f] = vel + m * (f - prof)
    
    return expandido

def preencher_horizontal(perfilA, perfilB, lA, lB, nPontos):
	#Interpola dois perfils para encontrar valores faltantes
	
	# Une o perfil de velocidade dos perfils a cada profundidade
    conj = list(zip(perfilA, perfilB))

    nLin = len(conj)
	# Cria nova matriz para receber Perfil A + Pontos Faltantes + Perfil B
    matriz = np.zeros((nLin, nPontos + 2))

    for i in range(nLin):
    	# Primeira linha preenchendo com o perfil A e a última com o perfil B
        matriz[i][0] = conj[i][0]
        matriz[i][-1] = conj[i][1]
    
	# Diferença de latitude/longitude entre os perfils
    dx = (lB - lA) / nPontos
    
    for i in range(nLin):
        par = conj[i]
        m = (par[1] - par[0]) / (lB - lA)

        for j in range(1, nPontos + 1):
		# Diferença latitude/longitude entre aquele elemento e o perfil A
            dL = j * dx
            matriz[i][j] = par[0] + (m * dL)
    
    return matriz
