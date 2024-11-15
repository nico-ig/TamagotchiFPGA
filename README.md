# ____gotchi  

Implementação em Verilog de um tamagotchi para ser utilizado em FPGA's.  

O conceito do Tamagotchi é ser uma espécie de pet que o dono tem que cuidar.

![Maquina de estados](Diagramas/MaquinaDeEstados.png)  

Para uma primeira implementação, geramos essa máquina de estados: </br>
**IDLE** - Tamagotchi parado executando animações mostrando ele se mexendo, olhando em volta, etc.</br>
**DORMINDO** - Ao pressionar o botão 2, o pet executará a animação de dormir. Ao apertar o botão 2, ele voltará ao estado *IDLE*, mas não antes do estado *ACORDANDO*. </br>  
**ACORDANDO** - Ocorre quando o botão 2 é apertado durante o estado *DORMINDO*, executará a animação de acordar e voltará para o estado *IDLE*. </br>  
**COMENDO** - Ao pressionar o botão 1, o pet come algo. </br>  
**LIMPANDO A BOCA** - Ocorre quando o botão 1 é apertado durante o estado *COMENDO*, executará a animação de limpar a boca e voltará para o estado *IDLE*.  </br>  
**DANDO AULA** - Ao pressionar o botão 1 ao mesmo tempo que o botão 2, o pet executará a animação de dar aula, ao pressionar os dois botões novamente ele irá para o estado *VOLTANDO*. </br>   
**VOLTANDO** - Ocorre quando os dois botões são pressionados durante o estado *DANDO AULA*, executará a animação de voltar para o *IDLE*.  </br>  
**MORTO** - Ocorre quando alguma das barras zera, levando o pet à morte.  </br>  

## Funcionamento  

Resumidamente, todas as ações executáveis seguem o mesmo padrão de funcionamento: </br>  

IDLE --> Botão X --> Tela de animação da ação --> Botão X --> Tela de animação de encerramento da ação --> IDLE </br>

Durante todas as telas (Menos a de morte), as barras de Fome, Sono e Felicidade aparecerão no topo da tela. Além disso, enquanto uma ação tiver sendo executada, o atributo correspondente será preenchido aos poucos e será possível ver isso acontecendo. </br>  

Ao morrer, para resetar pode ser interessante segurar os dois botões ao mesmo tempo. </br>  

## Módulos

### Controlador Botões

Módulo que recebe a entrada dos botões e trata elas para a saída.

### Controlador Principal  

O módulo que controla a lógica principal do Tamagotchi, recebe a saída do **controlador_botoes** como entrada, indica qual estado que se encontra, chama as animações de cada estado e cuida de combinar os estados com a imagem principal.  

### Controlador Estado

Módulo que cuida do estado passado e opera sobre ele, diminuindo ou aumentando seu valor.  

### Memória Imagens

Esse módulo mantém as imagens das animações de cada estado, em sequência uma da outra. Recebe um endereço como entrada e devolve uma imagem como saída.

### Controlador Display

Módulo que produz a imagem no Display efetivamente, recebe uma imagem e a mostra no display.  
