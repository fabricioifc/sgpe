SGPE - PlanoDeEnsinoIF - Sistema gerenciador de planos de ensino
================

Este sistema está sendo desenvolvido no Instituto Federal Catarinense - Campus Fraiburgo.

Cada disciplina ofertada pela instituição precisa de um plano de ensino, criado pelo seu respectivo professor. O objetivo é desenvolver um sistema para gerenciar, criar e publicar estes planos de ensino criados em cada disciplina.

Na prática, o setor responsável vai gerenciar as disciplinas que serão ofertadas em cada ano/semestre letivo. Ao ser ofertada, o professor poderá escrever seu plano de ensino, que será aprovado ou reprovado.

Com o plano de ensino pronto e aprovado, o mesmo estará visível de forma pública no sistema.

-----------
Tecnologias utilizadas
================
<ul>
  <li>Linguagem de programação: Ruby 2.4.1</li>
  <li>Framework MVC: Rails 5.1.3</li>
  <li>Banco de Dados: Postgresql 9.6</li>
  <li>IDE: Atom</li>
  <li>Controle de versão: GIT/GITHUB</li>
</ul>

-----------
Deploy
================

O deploy da aplicação é feito em dois ambientes.

<ul>
  <li><b>STAGING:<b> Ambiente de aprovação. Onde o cliente pode acessar e aprovar as tarefas desenvolvidas.</li>
  <li><b>PRODUCTION:<b> Ambiente de produção. Ambiente real da aplicação.</li>
</ul>

Cada ambiente possui uma base de dados distinta.

O deploy da aplicação é feita de forma automatizada, através da gem MINA em conjunto com o github. Basta configurar o IP da máquina (staging, production) e realizar o deploy.

- Para o ambiente de aprovação (staging) é utilizado a ramificação (branch) staging.
- Para o ambiente de produção (production) é utilizado a ramificação (branch) master.
