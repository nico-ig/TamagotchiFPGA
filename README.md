# ZANAGOTCHI  

Implementação em Verilog de um tamagotchi para ser utilizado em FPGA's.  

O conceito do Tamagotchi é ser uma espécie de pet que o dono tem que cuidar.

![Maquina de estados](Diagramas/maquina_de_estados.png) 

Para uma primeira implementação, geramos essa máquina de estados: </br>
**IDLE** - Zanagotchi parado executando animações mostrando ele se mexendo, olhando em volta, etc. 

- Ao pressionar o botão **1**: Zanagotchi vai para o estado *COMENDO*;
- Ao pressionar o botão **2**: Zanagotchi vai para o estado *DORMINDO*;
- Ao pressionar o botão **1 e 2** juntos: Zanagotchi vai para o estado *DANDO_AULA*;
- Ao segurar o botão **1 e 2** juntos: Reseta o game, volta para a tela de *INTRO* com os atributos iniciais;  

**INTRO** - Tela inicial do jogo, ao apertar algum botão vai para **IDLE** </br>
**COMENDO** - Zanagotchi executa animação de comer e seu atributo **Fome** aumenta em uma taxa constante. </br>
**DORMINDO** - Zanagotchi executa animação de dormir e seu atributo **Sono** aumenta em uma taxa constante. </br>
**DANDO_AULA** - Zanagotchi executa animação de dar aula e seu atributo **Felicidade** aumenta em uma taxa constante. </br>
**MORTO** - Se algum dos atributos chegar a um valor menor ou igual a 10, um túmulo é mostrado na tela. </br>

## Funcionamento  

Resumidamente, todas as ações executáveis seguem o mesmo padrão de funcionamento: </br>  

IDLE --> Botão X --> Tela de animação da ação --> Qualquer botão --> IDLE </br>

Durante todas as telas (Menos a de morte e de intro), as barras de Fome, Sono e Felicidade aparecerão no topo da tela. Além disso, enquanto uma ação estiver sendo executada, o atributo correspondente será preenchido aos poucos e será possível ver isso acontecendo. </br>  

## Módulos

### Zanagotchi

Módulo do topo que junta todos os módulos necessários para funcionamento do Zanagotchi.

### Controlador Estados  

Módulo que controla a troca de estados baseado na combinação de botões pressionados.  

### Controlador Imagens

Módulo que retorna bit a bit de uma imagem de acordo com o estado, e também as barrinhas que indicam os atributos.  

### Controlador Display

Módulo que efetivamente pinta os pixels da tela do display de acordo com os dados recebidos.  

### Controlador Botão

Módulo que recebe a entrada dos botões e trata elas para entrarem no controlador de estados corretamente.

### Controlador Atributos

Módulo que controla operações sobre os atributos definidos baseado no estado atual.  

# Demonstração

https://github.com/user-attachments/assets/c40858f9-f8aa-432d-b677-2abeecd659a0

https://github.com/user-attachments/assets/c27b20bd-8ed9-48cc-8310-7b1dbebad947

https://github.com/user-attachments/assets/d2f8234d-6d3c-4a06-8f7a-0b176bbc055d

https://github.com/user-attachments/assets/436bda3e-b3ae-4d3b-855d-912720f47fe8

![sad_screen](https://github.com/user-attachments/assets/6ec6da02-4349-4143-ad4b-a19c7315560e)

![idle_screen](https://github.com/user-attachments/assets/b71782d6-3a8f-4528-816f-b18af79e280a)

![init_screen](https://github.com/user-attachments/assets/7ee596e2-d8c4-4066-b355-bbd78907ef2c)

![wiring-1](https://github.com/user-attachments/assets/8138d743-958a-4a63-87a4-94085140eb43)

![wiring-2](https://github.com/user-attachments/assets/f70db41b-acbc-4aa9-ad51-2351de7fdcb7)

![wiring-top](https://github.com/user-attachments/assets/f61971b8-fd9c-4c20-8bca-6839d7820e3a)
