function readHycom(limites, datas)
  norte = num2str(limites(1));
  sul = num2str(limites(2));
  leste = num2str(limites(3));
  oeste = num2str(limites(4));
  
  secao = [norte " " sul " " leste " " oeste]
  
  inicio = num2str(datas(1));
  fim = num2str(datas(2));
  
  dts = [inicio " " fim]
  
  [status, _] = system("ls tcc");
  
  if status != 0
    system("mkdir tcc");
  endif
  
  system(["ksh downloadHycom.ksh " dts " " secao " ./tcc/br_data"])
endfunction