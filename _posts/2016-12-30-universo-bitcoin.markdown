---
published: true
title: O Universo Bitcoin 
layout: post
---

> Esse artigo tem o intuito de explicar o funcionamento das criptomoedas, em especial a mais famosa delas: o [Bitcoin](https://www.bitcoin.com/). 

----------
* auto-gen TOC:
{:toc}
----------

## Introdução

A primeira ideia de criptomoeda surgiu em 2008 em um pequeno artigo de Satoshi Nakamoto entitulado ["Bitcoin: A peer-to-peer electronic cash system"](https://bitcoin.org/bitcoin.pdf). Embora ninguém realmente saiba a identidade verdadeira de Nakamoto, seu artigo de apenas 9 páginas revolucionou o mundo das moedas digitais.

A ideia geral das criptomoedas é bem simples: manter todas as transações e carteiras seguras através de criptografia, fazendo com que só você tenha acesso à sua carteira e só você posso gastar suas criptomoedas. Em palavras mais simples, o sistema não é baseado em confiança, e sim em prova criptográfica.

Em palavras ainda mais simples: ao realizar um pagamento, há uma relação de confiança. Geralmente, se confia no banco utilizado como terceiro elemento para intermediar o pagamento. Nesse caso, o banco é responsável por ficar com seu dinheiro e mover de conta em conta. É necessário que ambas as partes confiem em uma terceira entidade, como um banco, para que ambos tenham a certeza que seu dinheiro chegará em segurança.

Mas isso mudou em 31 de outubro de 2008, com a introdução de um sistema capaz de, através de criptografia, permitir transações sem a necessidade de terceiros. E esse é um serviço comunitário, e que pode ser verificado por qualquer: para que uma transação seja aceita, ela tem que ser adicionada à algum bloco, e é aí que entram os mineradores de Bitcoin, trabalhando para manter os blocos consistentes.

Para primeiro entender como isso é feito, deve-se entender o que é uma **função hash**.

## Funções Hash

A função hash, em poucas palavras, é uma função matemática não reversível que gera uma saída de tamanho fixo para uma determinada entrada. 

Um exemplo bem simples de função hash que transorma um número decimal em um outro de tamanho unitário é somar todos os algarismos e calcular o resto da divisão por 10. Nesse contexto, aplicar a nossa função hash no número **403** gera **7**, pois é **4 + 0 + 3 = 7**, e o resto dessa divisão por 10 é **7**. Se aplicado a **5454**, a função hash é **8**, pois **5 + 4 + 5 + 4 = 18**, e o resto da divisão por 10 é **8**. Note que essa função não é reversível: não existe meio de se obter o número original através do valor hash, pois parte da informação é perdida no processo.

Uma função hash tem diversos usos, mas geralmente algumas propriedades são esperadas, como:

- **Determinismo**, onde um valor sempre gera a mesma hash.
- **Distribuição uniforme**, de forma que o resultado seja pseudo-aleatório e com iguais probabilidades para qualquer resultado.
- **Rápida de ser gerada**, mas não tão rápida que possa ser computada aos milhares facilmente.
- **Irreversível**, sendo impraticável computacionalmente de achar a entrada original a partir da hash.
- **Não-colisão**, sendo impraticável achar duas entradas com a mesma hash.
- Uma pequena mudança no valor de entrada causa uma grande mudança no valor da hash.

Abaixo há uma caixa de texto que computa um algoritmo de hash famoso, o [SHA256](https://en.wikipedia.org/wiki/SHA-2), utilizado como algoritmo da Bitcoin.

<div class="fancybox">
<h3 style="margin-top: 0rem;">SHA256</h3>
<input type="text" id="myInput" style="width: 100%; height: 40px; font-size:22px;" oninput="computeHash()">
<p id="sha-output" style="font-size: 16px; margin-bottom: 0rem; font-family: monospace; word-wrap:break-word;"></p>
<script src="https://cdn.rawgit.com/chrisveness/crypto/9a15aa9/sha256.js"></script>
<script>
function computeHash() {
    var x = document.getElementById("myInput").value;
    var hash = Sha256.hash(x);
    document.getElementById("sha-output").innerHTML = hash;
}
window.onload = computeHash;
</script>
</div>


Vamos analisar rapidamente a função hash SHA256. As colisões são no mínimo improváveis. Como a saída possui sempre 256 bits, as possibilidades são 2<sup>256</sup>, que é aproximadamente 10<sup>77</sup> ou **1 seguido de 77 zeros**. Isso quer dizer que pode-se atribuir uma hash distinta para cada conjunto de 1000 átomos no universo.

Existe um segundo uso muito especial para funções hash: a ofuscação de senhas. Supondo que você queira guardar as senhas dos seus usuários sem *realmente* saber as senhas deles. Isso é possível? Sim. Basta armazenar a hash das senhas individuais. Ao receber a senha que o usuário digitou, basta tirar a hash dela e comparar com a que você possui armazenada. Se as duas coincidirem, já que a probabilidade de colisão é zero para senhas, então a senha inserida está correta.

Outra utilização é fazer a verificação da integridade de arquivos. Já que a hash é praticamente única, para ter certeza que alguém recebeu o arquivo *exato* que você enviou, basta pedir que ele tire a hash e compare com a quem você tem do seu arquivo. É implausível que alguém consiga modificar o arquivo antes do fim do universo de tal forma que a hash continue a mesma. 

Como a hash é pseudoaletória, é necessário gerar uma quantidade exorbitante de hashes por segundo para se achar uma hash com propriedades desejadas. Já vimos que é virtualmente impossível achar uma hash específica, mas e um conjunto de hashes? Tente por exemplo achar uma hash que inicie com o número **1** na forma hexadecimal (digite na caixa de texto acima). Não são necessárias muitas tentativas para achar o número **9**, ou também a letra **d**. 

Agora tente achar algo que gere uma hash iniciando em **0**. Vou te poupar do trabalho: **o número é 39**. Quer um desafio ainda mais difícil? Tente achar uma hash que inicie em **5 zeros**. Esse é ainda mais complicado: **596138**. Com **7 zeros**? Não é preciso ir muito mais longe, **665782** já resolve o problema, mas além dele, o próximo que inicia com 7 zeros é apenas **81308074**! Embora seja fácil encontrar hashes com pequenos número de zeros usando apenas um processador e um script em Python, a dificuldade aumenta imensamente conforme a ''raridade'' da descoberta aumenta. Embora tenha sido relativamente fácil encontrar todos os números anteriores, o número **426479724**, que inicia com **8 zeros**, exigiu cerca de 30 minutos ou duas xícaras de café (de fato é o único com 8 zeros menor que 1 trilhão).

Esse conceito de tempo de processamento é importante para as criptomoedas e é chamado de **Prova de Trabalho** ou **[Proof-of-Work](https://en.wikipedia.org/wiki/Proof-of-work_system)**. Em suma, você tem que provar que realmente trabalhou para criar valor, ou minerar uma Bitcoin.

## Conceito de Transação

Uma transação nada mais é do que uma prova de que o dinheiro foi enviado de uma pessoa para outra. Suponha que o usuário **Alpha** queira enviar uma quantia para o usuário **Beta**. A imagem a seguir representa um envio desse tipo retirado de um bloco aleatório. Note que o usuário **Alpha**, além de enviar uma quantia para **Beta**, envia uma quantidade para seu próprio endereço de Bitcoin. Isso ocorre porque cada transação deve equivaler à quantidade de Bitcoins na carteira de quem está enviando. O que sobrar na carteira que não for enviado para nenhuma outra carteira é utilizado como **taxa de transação** e é enviado para quem minerar o bloco.

<img src="https://cloud.githubusercontent.com/assets/8211602/25315163/5bc9d36a-2827-11e7-873b-db2c0814e9a2.png" style="width: 100%;"/>

No entanto, cada transação precisa ser assinada para ser válida. Isso é feito utilizando-se de [criptografia e chaves públicas e privadas](https://en.wikipedia.org/wiki/Digital_signature). Ao criar uma transação, o usuário a assina com sua **chave privada** (que só ele sabe, a chave que representa sua carteira) e envia também sua **chave pública** (que não pode ser usada para obter a chave privada).

Uma propriedade matemática dessas chaves é que somente a chave privada pode assinar mensagens, e a chave pública pode ser utilizada para verificar a autenticidade, se quem enviou a transação realmente possui a chave privada, e também verificar integridade, se essa transação não foi alterada no caminho. É extremamente implausível computacionalmente para a tecnologia atual atacar por força bruta as chaves, portanto, **nem mesmo o dono das Bitcoins pode resgatá-las caso a chave privada seja perdida.**

Note que as transações são anunciadas publicamente para todos os nodos, de forma que qualquer um pode ter registro das transações que vão sendo feitas. Mas para realmente consolidar as transações, elas são reunidas em blocos.

## Bloco

O bloco nada mais é do que uma lista de transações. O bloco é composto de 6 campos, que serão explicados mais adiante:

- **Versão**: versão do bloco.
- **Hash do bloco anterior**: SHA-256 do bloco anterior.
- **Hash das transações**: SHA-256 da raiz da [árvore de Merkle](https://en.wikipedia.org/wiki/Merkle_tree) de todas as transações. Essa é uma hash combinada de todas as transações para o bloco possuir tamanho fixo.
- **Tempo**: convenção de tempo como segundos transcorridos desde 1970-01-01T00:00 UTC.
- **Target**: número de 256 bits (assim como a hash) que define a dificuldade do bloco ao ser minerado.
- **Nonce**: número de 32 bits que pode ser variado livremente.

Um exemplo de um bloco real pode ser visto abaixo. Note a quantidade de zeros da hash do bloco.

<img src="https://cloud.githubusercontent.com/assets/8211602/25316075/932c32da-2836-11e7-8a2f-10470e8d4d62.png" style="width: 100%;"/>

## Blockchain (Cadeia de Blocos) 

Como pode ser visto na definição de bloco, cada bloco possui a hash do bloco anterior. Isso significa que todos os blocos, à partir do primeiro, estão "ligados" ao bloco anterior, em uma cadeia única. No momento em que um bloco novo é criado, ele é adicionado no *blockchain* e o próximo bloco já pode ser minerado. O minerador então recebe a recompensa por minerar o bloco mais a soma de todas as taxas de transações.

<img src="https://qzprod.files.wordpress.com/2013/12/illos6.png" style="width: 100%;"/>

O objetivo da Bitcoin é ter um bloco minerado a cada 10 minutos. Com o aumento do número de mineradores, também cai o tempo necessário para mineração. Para corrigir esse problema, a cada 2016 blocos, ou aproximadamente 2 semanas, a dificuldade é alterada e enviada na variável **target**.

Para minerar, basta utilizar o algoritmo ``SHA256(SHA256(bloco))`` e comparar se o resultado é menor que o **target**. Se for, você minerou com sucesso e pode receber suas Bitcoins. Caso contrário, você deve incrementar o **Nonce** e tentar novamente. O processo de minerar consiste em **tentar várias combinações de transações e Nonce até achar uma configuração com o número de zeros correto (hash menor que o target)**. Embora pareça simples, note que cada 0 adicionado aumenta exponencialmente o trabalho necessário. Você pode comprovar isso tentando achar qualquer valor que gere uma hash que inicie com 10 zeros!

Os blocos são minerados por um único motivo: manter a blockchain consistente e registrar as transações. Uma vez que uma transação é adicionada em um bloco, ela está confirmada, e cada novo bloco que é gerado à sua frente resulta em mais uma confirmação. Como todos os nodos na rede podem ter sua própria cópia do blockchain, todos podem verificar que as transações e as hashes são válidas.

### Dificuldade com o tempo

A próxima figura mostra como a dificuldade dos blocos cresceu com o tempo. Note que a dificuldade também é medida em PHash/s, ou Peta Hashes por segundo (**1P = 10<sup>15</sup>**), uma produção combinada exorbitante de hashes!

<img src="https://bitcoin.sipa.be/speed-lin-ever.png" style="width: 100%;"/>

### Proteção contra fraude

A escolha de uma cadeia de blocos não é à toa: supondo que alguém queira gastar a mesma quantia de Bitcoins duas vezes. Para isso, ele pode tentar alterar o bloco em que sua transação foi registrada para retirá-la do bloco. Isso implica em recalcular esse bloco e todos os posteriores até o bloco honesto atual, já que a cadeia válida é sempre a mais longa. Nesse processo, ele terá que superar todo o poder computacional combinado de todos os outros mineradores, que é inviável.

As transações, mesmo sendo completamente públicas, estão seguras pois **a menor alteração no bloco implica em uma solução completamente diferente para o Nonce, que implica em resolver o problema computacional praticamente impossível de superar todos os outros mineradores juntos**.

### Porque minerar?

Mas você deve estar se perguntando: porque alguém gastaria tempo e processamento para tentar minerar um bloco? A resposta é simples: todo bloco possui uma recompensa!

A recompensa é inicialmente **50 BTC** e é cortada ao meio a cada **210,000 blocos**, ou aproximadamente 4 anos. **O número máximo de Bitcoins que serão produzidas será de 21,000,000 BTC**, portanto, a recompensa passará de 6,25 BTC diretamente para 0 BTC.

Quando a recompensa for zero, nenhuma nova Bitcoin poderá ser criada, mas os blocos continuarão a ser gerados, porque as transações continuarão acontecendo. Acredita-se que, com o aumento do número de transações, a recompensa virá através das **taxas de transação**, que são valores pequenos que os usuários "doam" para os mineradores para que suas transações tenham preferência ao serem adicionadas aos blocos. O minerador, ao minerar uma grande quantidade de transações por vez, garante que receberá uma quantia maior por taxas, que serve como estímulo para continuar a mineração.
