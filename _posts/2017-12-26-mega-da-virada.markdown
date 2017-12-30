---
published: true
title: A Matemática da Mega da Virada
layout: post
abstract: Na época de fim de ano, muitas pessoas voltam suas atenções para um evento probabilístico chamado Mega da Virada. Mas será que elas entendem a real chance de ganharem?
---

<!-- Include MathJax to render LaTeX. This might not work -->
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
      jax: ["input/TeX","output/SVG"],
      inlineMath: [['\(','\)']]
   });
</script>
<script type="text/javascript"
          src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js">
</script>

> Na época de fim de ano, muitas pessoas voltam suas atenções para um evento probabilístico chamado Mega da Virada. Mas será que elas entendem a real chance de ganharem?

## A probabilidade

A Mega-sena é um evento da loteria brasileira em que, dentre 60 números, nomeados de 1 a 60, o jogador deve marcar uma quantidade entre 6 e 15 números. O vencedor do prêmio máximo é aquele que corretamente marca os 6 números sorteados. O preço da aposta é R$ 3,50, então esse tipo de sorteio acumulado no final do ano é visto por muitos como uma forma de enriquecer facilmente apenas na sorte.

Em termos matemáticos, é muito fácil calcular a chance de ganhar nesse evento. O número de cartões possíveis é dado pela combinação de 60, 6 a 6, ou:

$$C_{60}^6 = \frac{60!}{54!6!} = 50.063.860$$

Sua chance de acertar o cartão é **uma em cinquenta milhões, sessenta e três mil e oitocentos e sessenta**! Para jogar todos os cartões possíveis, você teria que desembolsar aproximadamente 175 milhões de reais.

O jogo ainda te dá a chance de jogar vários cartões de uma só vez em um cartão só, preenchendo mais de 6 números. Por exemplo, ao jogar 7 números, você estará jogando o equivalente a 7 cartões diferentes, e o preço do cartão subirá proporcionalmente. Não existe nenhuma vantagem em jogar 7 cartões ou 6 números ou 1 cartão com 7 números.

Você pode alterar os parâmetros abaixo e ver como a sua probabilidade muda quanto mais números você joga. Tente alterar as propriedades do concurso! Quantos números você precisa jogar para ter 50% de chance de ganhar, o equivalente a ganhar no cara-ou-coroa? **A reposta é 54.** Mesmo jogando 59 números em 60, sua chance seria de 90%.

<div class="fancybox">
<h3 style="margin-top: 0rem; margin-bottom: 1rem">Probabilidade de Ganhar</h3>

<link href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/6.4.3/rzslider.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/6.4.3/rzslider.min.js"></script>
<div id="myapp" ng-controller="TestController as vm">
    <rzslider rz-slider-model="vm.totais.value" rz-slider-options="vm.totais.options" style="margin-bottom: 1.5rem"></rzslider>
    <rzslider rz-slider-model="vm.numeros.value" rz-slider-options="vm.numeros.options"></rzslider>
</div>
<div style="margin-top: 1rem">Cartões totais do concurso: <b id="total_cards"></b></div>
<div>Cartões totais jogados: <b id="chosen_cards"></b></div>
<div>Preço da Aposta: <b id="preco"></b></div>
<div>Chance de ganhar: <b id="chance"></b></div>

<script>
var myApp = angular.module('myappdom', ['rzModule']);

myApp.controller('TestController', TestController);

var f = [];
function factorial (n) {
  if (n == 0 || n == 1)
    return 1;
  if (f[n] > 0)
    return f[n];
  return f[n] = factorial(n-1) * n;
}

function updateProbability (t, n) {
  var cards = Math.round(factorial(t)/factorial(t-6)/factorial(6));
  var chosen_cards = Math.round(factorial(n)/factorial(6)/factorial(n-6));
  var preco = chosen_cards * 3.5;
  var chance = chosen_cards/cards*100;
  document.getElementById("total_cards").innerHTML = cards;
  document.getElementById("chosen_cards").innerHTML = chosen_cards;
  document.getElementById("preco").innerHTML = 'R$ ' + preco.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
  document.getElementById("chance").innerHTML = chance + '%';
}

function TestController() {
  var vm = this;

  vm.totais = {
    value: 60,
    options: {
      floor: 6,
      ceil: 70,
	  onChange: function(id) {
        vm.numeros.options.maxLimit = vm.totais.value;
		if(vm.numeros.value > vm.totais.value)
			vm.numeros.value = vm.totais.value;

        updateProbability(vm.totais.value, vm.numeros.value);
	  },
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Números totais</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }


  vm.numeros = {
    value: 6,
    options: {
      floor: 6,
      ceil: 70,
	  onChange: function(id) {
        updateProbability(vm.totais.value, vm.numeros.value);
	  },
      maxLimit: vm.totais.value,
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Números jogados</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }
    
 updateProbability(vm.totais.value,vm.numeros.value);
}

angular.bootstrap(document.getElementById('myapp'), ['myappdom']);
</script>
</div>

## Um desperdício de papel

Um cartão comum da Mega-Sena possui 14x8.4 cm. Acredite. Eu medi. Isso equivale a 117.6 cm² de papel. Para preencher todos os mais de 50 milhões de cartões possíveis, são necessários 588751 m² de papel, que é aproximadamente o tamanho da cidade do Vaticano. 

Considerando a densidade comum do papel A4 de 75 g/m², são necessárias aproximadamente 44 toneladas de papel para todos esses números.

Considerando a espessura comum de 0.1 mm, podemos empilhar os bilhetes ao invés de colocá-los lado a lado. O resultado são 5.000 m de altura de papel. Uma altura considerável, mas não é suficiente para alcançar o Everest, com seus imponentes 8.848 m de altura.

## Todo número nasce igual... ou quase

Dentro de uma distribuição aleatória, é esperado que com o passar do tempo ela se torne uniforme, com igual probabilidade para todos os termos. Isso é realmente o que acontece analisando todas as ocorrências desde 1996.

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
<script src="https://cdn.rawgit.com/jtblin/angular-chart.js/master/dist/angular-chart.min.js"></script>

<canvas id="myChart" width="65" height="150" style="margin-bottom: 1rem"></canvas>
<script>
var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
        labels: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60],
        datasets: [{
            label: 'Número de Ocorrências',
            data: [198, 206, 190, 219, 232, 201, 189, 199, 182, 224, 190, 199, 209, 185, 183, 209, 215, 198, 185, 192, 177, 173, 219, 218, 182, 164, 202, 213, 206, 211, 194, 211, 217, 206, 196, 204, 204, 195, 185, 188, 208, 214, 211, 204, 199, 187, 199, 186, 200, 207, 218, 213, 227, 217, 172, 201, 187, 191, 197, 186],
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>

O esperado é que cada número possua a probabilidade independente de **1/60** de ser sorteado, ou aproximadamente **1.67%** das vezes.

Curiosamente, alguns números se destacam: o número 26 é o que menos apareceu em todos os concursos, sendo sorteado **164 vezes** ou **1.37%** das vezes. O número com maior probabilidade é o 5, com **232 ocorrências** e aparecendo **1.93%** das vezes.

O que esses dados significam? Absolutamente nada. Com um desvio padrão de 14.4, essa distribuição está bem próxima de uniforme. As variações encontradas são devido ao baixo número de amostras, e essa diferença tende a diminuir com o tempo, quando mais e mais números são sorteados.

## Mas minha probabilidade de ganhar aumenta com o tempo... certo?

Um erro muito comum das pessoas é assumir que a probabilidade vai aumentando com o tempo: quanto mais tempo passa, mais provável é que você ganhe alguma coisa.

Tomemos como exemplo o lançamento de uma moeda, escolhendo coroa. É esperado que a probabilidade de ganhar escolhendo coroa seja de 50%. Agora vamos supor que alguém jogue a moeda duas vezes, tentando obter coroa. São 4 possibilidades possíveis:

- **K** **C**
- **C** **K**
- **C** **C**
- **K** **K**

Podemos observar que a probabilidade combinada é de 75%, pois em 3 dos 4 casos um dos lançamentos é coroa. Isso se deve ao fato de os lançamentos serem **independentes**. Caso você perca no primeiro lançamento, a probabilidade de ganhar cai imediatamente para 50%.

O mesmo ocorre na Mega-Sena. Sua probabilidade de ganhar em cada concurso continua a mesma, mas jogar mais concursos aumenta de leve suas chances de ganhar. A equação que rege essa probabilidade é:

$$P_G = 1 - (P_P)^n$$

Vamos digerir essa fórmula: a probabilidade ganhar, é igual a 1 menos a probabilidade de perder elevado ao número de tentativas. Voltando ao exemplo da moeda, onde a probabilidade de perder é **1/2** e são realizadas duas tentativas:

$$P_G = 1 - \left(\frac{1}{2}\right)^2 = 0.75 = 75 \, \%$$

Por fim, a chance de ganhar na Mega com n concursos também segue essa lógica:

$$P_G = 1 - \left(\frac{50.063.859}{50.063.860}\right)^n$$

Que como você pode perceber de antemão, é pequeno para valores pequenos de n, o que já era de se esperar: é preciso participar de muitos concursos para ter uma probabilidade alta de ganhar. Mas quantos exatamente? O gráfico a seguir mostra como a chance de ganhar varia com o número de concursos participados.

<canvas id="myOtherChart" width="130" height="100" style="margin-bottom: 1rem"></canvas>
<script>
var ctx = document.getElementById("myOtherChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'scatter',
    data: {
        datasets: [{
            label: 'Probabilidade de Ganhar',
            data: [{x:1.0,y:1.9974e-08},
            {x:2.0,y:3.9949e-08},
            {x:3.0,y:5.9923e-08},
            {x:4.0,y:7.9898e-08},
            {x:5.0,y:9.9872e-08},
            {x:6.0,y:1.1985e-07},
            {x:7.0,y:1.3982e-07},
            {x:8.0,y:1.598e-07},
            {x:9.0,y:1.7977e-07},
            {x:10.0,y:1.9974e-07},
            {x:20.0,y:3.9949e-07},
            {x:30.0,y:5.9923e-07},
            {x:40.0,y:7.9898e-07},
            {x:50.0,y:9.9872e-07},
            {x:60.0,y:1.1985e-06},
            {x:70.0,y:1.3982e-06},
            {x:80.0,y:1.598e-06},
            {x:90.0,y:1.7977e-06},
            {x:100.0,y:1.9974e-06},
            {x:200.0,y:3.9949e-06},
            {x:300.0,y:5.9923e-06},
            {x:400.0,y:7.9898e-06},
            {x:500.0,y:9.9872e-06},
            {x:600.0,y:1.1985e-05},
            {x:700.0,y:1.3982e-05},
            {x:800.0,y:1.5979e-05},
            {x:900.0,y:1.7977e-05},
            {x:1000.0,y:1.9974e-05},
            {x:2000.0,y:3.9948e-05},
            {x:3000.0,y:5.9922e-05},
            {x:4000.0,y:7.9895e-05},
            {x:5000.0,y:9.9867e-05},
            {x:6000.0,y:0.00011984},
            {x:7000.0,y:0.00013981},
            {x:8000.0,y:0.00015978},
            {x:9000.0,y:0.00017975},
            {x:10000.0,y:0.00019972},
            {x:20000.0,y:0.00039941},
            {x:30000.0,y:0.00059906},
            {x:40000.0,y:0.00079866},
            {x:50000.0,y:0.00099823},
            {x:60000.0,y:0.0011978},
            {x:70000.0,y:0.0013972},
            {x:80000.0,y:0.0015967},
            {x:90000.0,y:0.0017961},
            {x:100000.0,y:0.0019955},
            {x:200000.0,y:0.0039869},
            {x:300000.0,y:0.0059744},
            {x:400000.0,y:0.007958},
            {x:500000.0,y:0.0099375},
            {x:600000.0,y:0.011913},
            {x:700000.0,y:0.013885},
            {x:800000.0,y:0.015853},
            {x:900000.0,y:0.017816},
            {x:1000000.0,y:0.019776},
            {x:2000000.0,y:0.039162},
            {x:3000000.0,y:0.058163},
            {x:4000000.0,y:0.076789},
            {x:5000000.0,y:0.095047},
            {x:6000000.0,y:0.11294},
            {x:7000000.0,y:0.13049},
            {x:8000000.0,y:0.14768},
            {x:9000000.0,y:0.16454},
            {x:10000000.0,y:0.18106},
            {x:20000000.0,y:0.32934},
            {x:30000000.0,y:0.45077},
            {x:40000000.0,y:0.55021},
            {x:50000000.0,y:0.63165},
            {x:60000000.0,y:0.69834},
            {x:70000000.0,y:0.75296},
            {x:80000000.0,y:0.79769},
            {x:90000000.0,y:0.83432},
            {x:100000000.0,y:0.86432},
            {x:200000000.0,y:0.98159},
            {x:300000000.0,y:0.9975},
            {x:400000000.0,y:0.99966},
            {x:500000000.0,y:0.99995},
            {x:600000000.0,y:0.99999}],
            borderColor: 'rgba(54, 162, 235, 1)',
            pointBackgroundColor: 'rgba(54, 162, 235, 1)', 
            pointBorderWidth: 3,
            pointRadius: 1,
            showLine: true
        }]
    },
    options: {
        scales: {
            xAxes: [{
                type:'logarithmic',
                scaleLabel: {
                    labelString: 'Concursos participados',
                    display:true
                }
            }],
            yAxes: [{
                scaleLabel: {
                    labelString: 'Probabilidade de Ganhar',
                    display:true
                }
            }]
        }
    }
});
</script>

É incrível como o a probabilidade cai substituindo vários cartões em um mesmo concurso por apenas cartão em vários concursos. **Para ter aproximadamente 50% de chance de ganhar, você teria que participar de aproximadamente 30 milhões de concursos**.

Na marca de 100 milhões de concursos, você já deve ter o seu prêmio, com 86% de chance. Mas para valores até 500 mil concursos, a probabilidade continua insignificante, de menos de 1%.

## Mas existe uma chance... certo?

Sim. A chance é infinitesimal, mas existe. Mas tenha em mente que ela é menor ou igual aos seguintes eventos:

- Tirar coroa no cara ou coroa **25 vezes seguidas.**
- Morrer em um acidente de avião. Sério.
- Ser morto por um meteoro. Sério².
- Jogar 9 dados e todos caírem com a face 6 voltada para cima.
- Ganhar um prêmio Nobel (não que prêmios Nobel sejam distribuídos ao acaso).

## Mas eu quero tentar!

Eu sei que apesar de tudo sua mão está tremendo de ansiedade para jogar na Mega-Sena. Então eu montei uma tabela para planejar as suas chances de ganhar! Insira quantos números você quer apostar por concurso, quantos concursos quer participar e ele te dá a probabilidade de ganhar! Você ainda pode aumentar suas chances diminuindo a dificuldade ou diminuir o preço do cartão. 

<div class="fancybox">
<h3 style="margin-top: 0rem; margin-bottom: 1rem">Probabilidade de Ganhar</h3>

<div id="myotherapp" ng-controller="FormController as vp">
<rzslider rz-slider-model="vp.totais.value" rz-slider-options="vp.totais.options" style="margin-bottom: 1.5rem"></rzslider>
<rzslider rz-slider-model="vp.numeros.value" rz-slider-options="vp.numeros.options" style="margin-bottom: 1.5rem"></rzslider>
<rzslider rz-slider-model="vp.preco.value" rz-slider-options="vp.preco.options" style="margin-bottom: 1.5rem"></rzslider>
<rzslider rz-slider-model="vp.concursos.value" rz-slider-options="vp.concursos.options" style="margin-bottom: 1.5rem"></rzslider>

<center>
<button ng-click="vp.resetar()" class="fancybutton" style="vertical-align:middle;"><span><i class="fa fa-refresh" aria-hidden="true"></i> Restaurar</span></button>
</center>

<div style="margin-top: 1rem">Cartões totais do concurso: <b id="total_cards_final"></b></div>
<div>Cartões totais jogados: <b id="chosen_cards_final"></b></div>
<div>Preço por Aposta: <b id="preco_final"></b></div>
<div>Chance por Aposta: <b id="chance_final"></b></div>
<div>Concursos: <b id="concursos_final"></b></div>
<div>Preço total: <b id="preco_ac_final"></b></div>
<div>Chance total: <b id="chance_ac_final"></b></div>

</div>

<script>
var myApp = angular.module('myotherappdom', ['rzModule']);

myApp.controller('FormController', FormController);

var f = [];
function factorial (n) {
  if (n == 0 || n == 1)
    return 1;
  if (f[n] > 0)
    return f[n];
  return f[n] = factorial(n-1) * n;
}

function factoryProbability (vp) {
  var t = vp.totais.value;
  var n = vp.numeros.value;
  var cards = Math.round(factorial(t)/factorial(t-6)/factorial(6));
  var chosen_cards = Math.round(factorial(n)/factorial(6)/factorial(n-6));
  var preco = chosen_cards * vp.preco.value;
  var chance = chosen_cards/cards;
  var chance_acumulada = 1 - Math.pow(1 - chance, vp.concursos.value);
  document.getElementById("total_cards_final").innerHTML = cards;
  document.getElementById("chosen_cards_final").innerHTML = chosen_cards;
  document.getElementById("preco_final").innerHTML = 'R$ ' + preco.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
  document.getElementById("chance_final").innerHTML = (chance*100).toFixed(13) + '%';
  document.getElementById("concursos_final").innerHTML = vp.concursos.value;
  document.getElementById("preco_ac_final").innerHTML = 'R$ ' + (preco * vp.concursos.value).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
  document.getElementById("chance_ac_final").innerHTML = (chance_acumulada*100).toFixed(13) + '%';
  return chance_acumulada;
}

function FormController() {
  var vp = this;

  vp.totais = {
    value: 60,
    options: {
      floor: 6,
      ceil: 70,
	  onChange: function(id) {
        vp.numeros.options.maxLimit = vp.totais.value;
		if(vp.numeros.value > vp.totais.value)
			vp.numeros.value = vp.totais.value;

        factoryProbability(vp);
	  },
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Números totais</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }


  vp.numeros = {
    value: 6,
    options: {
      floor: 6,
      ceil: 70,
	  onChange: function(id) {
        factoryProbability(vp);
	  },
      maxLimit: vp.totais.value,
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Números jogados</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }


  vp.preco = {
    value: 3.50,
    options: {
      floor: 0.01,
      ceil: 5,
      step: 0.01,
      precision: 2,
	  onChange: function(id) {
        factoryProbability(vp);
	  },
      maxLimit: vp.totais.value,
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Preço de cada Aposta</b>: R$' + value.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
		  default:
			return 'R$' + value.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
		}
	  }
    }
  }

  vp.concursos = {
    value: 1,
    options: {
      floor: 1,
      ceil: 1000,
      logScale: true,
	  onChange: function(id) {
        factoryProbability(vp);
	  },
	  translate: function(value, sliderId, label) {
		switch(label) {
		  case 'model':
	        return '<b>Concursos Participados</b>:' + value;
		  default:
			return value;
		}
	  }
    }
  }

  vp.resetar = function() {
    vp.totais.value = 60;
    vp.numeros.value = 6;
    vp.preco.value = 3.5;
    vp.concursos.value = 1;
    factoryProbability(vp);
  }
    
  factoryProbability(vp);
}

angular.bootstrap(document.getElementById('myotherapp'), ['myotherappdom']);
</script>


</div>
