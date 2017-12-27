---
published: true
title: A Matemática da Mega da Virada
layout: post
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

Você pode alterar os parâmetros abaixo e ver como a sua probabilidade muda quanto mais números você joga. Tente alterar as propriedades do concurso! Quantos números você precisa jogar para ter 50% de chance de ganhar, o equivalente a ganhar no cara-ou-coroa? **A reposta é 54.** Mesmo jogando 59 números em 60, sua chance seria míseros 90%.

<div class="fancybox">
<h3 style="margin-top: 0rem; margin-bottom: 1rem">Probabilidade de Ganhar</h3>

<link href="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/6.4.3/rzslider.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angularjs-slider/6.4.3/rzslider.min.js"></script>
<div ng-app="myapp">
  <div ng-controller="TestController as vm">
    <rzslider rz-slider-model="vm.totais.value" rz-slider-options="vm.totais.options" style="margin-bottom: 1rem"></rzslider>
    <rzslider rz-slider-model="vm.numeros.value" rz-slider-options="vm.numeros.options"></rzslider>
  </div>
</div>
<div style="margin-top: 1rem">Cartões totais do concurso: <b id="total_cards"></b></div>
<div>Cartões totais jogados: <b id="chosen_cards"></b></div>
<div>Preço da Aposta: <b id="preco"></b></div>
<div>Chance de ganhar: <b id="chance"></b></div>

<script>
var myApp = angular.module('myapp', ['rzModule']);

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

<canvas id="myChart" width="100" height="150" style="margin-bottom: 1rem"></canvas>
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

<canvas id="myOtherChart" width="100" height="50" style="margin-bottom: 1rem"></canvas>
<script>
var ctx = document.getElementById("myOtherChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,20000,30000,40000,50000,60000,70000,80000,90000,1e+05,2e+05,3e+05,4e+05,5e+05,6e+05,7e+05,8e+05,9e+05,1e+06,2e+06,3e+06,4e+06,5e+06,6e+06,7e+06,8e+06,9e+06,1e+07,2e+07,3e+07,4e+07,5e+07,6e+07,7e+07,8e+07,9e+07,1e+08,2e+08,3e+08,4e+08,5e+08,6e+08],
        datasets: [{
            label: 'Probabilidade de Ganhar',
            data: [1.9974e-08,3.9949e-08,5.9923e-08,7.9898e-08,9.9872e-08,1.1985e-07,1.3982e-07,1.598e-07,1.7977e-07,1.9974e-07,3.9949e-07,5.9923e-07,7.9898e-07,9.9872e-07,1.1985e-06,1.3982e-06,1.598e-06,1.7977e-06,1.9974e-06,3.9949e-06,5.9923e-06,7.9898e-06,9.9872e-06,1.1985e-05,1.3982e-05,1.5979e-05,1.7977e-05,1.9974e-05,3.9948e-05,5.9922e-05,7.9895e-05,9.9867e-05,0.00011984,0.00013981,0.00015978,0.00017975,0.00019972,0.00039941,0.00059906,0.00079866,0.00099823,0.0011978,0.0013972,0.0015967,0.0017961,0.0019955,0.0039869,0.0059744,0.007958,0.0099375,0.011913,0.013885,0.015853,0.017816,0.019776,0.039162,0.058163,0.076789,0.095047,0.11294,0.13049,0.14768,0.16454,0.18106,0.32934,0.45077,0.55021,0.63165,0.69834,0.75296,0.79769,0.83432,0.86432,0.98159,0.9975,0.99966,0.99995,0.99999],
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            xAxes: [{
            }],
            yAxes: [{
            }]
        }
    }
});
</script>
