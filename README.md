# ELIXIR

## CONCEITO DA LINGUAGEM

REVER

## COMANDOS IMPORTANTES

No terminal do elixir, pode usar comandos como:

Map. (TAB)
List. (TAB)

O que isso faz ? Lista uma documentação para nós, das funções de Map padrões da linguagem e o mesmo para List e
para todas as outras funções da linguagem como String, Float, Integer, Atom, etc.

## TIPOS PRIMITIVOS (BOOLEAN | STRING | FLOAT | INTEGER)

REVER

## LISTAS

As listas no Elixir possuem um sintaxe idêntica a arrays de outras linguagens como PHP e JavaScript;

Array (PHP/JavaScript) = [] | Lista (Elixir) = []

Porém, diferentemente das outras linguagens, o Elixir trabalha com essa sintaxe como sendo Listas Encadeadas, e por que isso ?

Bom, listas encadeadas não permitem um acesso direto a determinado valor nela armazenado (memória) e caso nós precisemos acessar
o segundo valor dessa lista, obrigatoriamente precisamos passar pelo primeiro pois existe a seguinte ordem de execução:

[1] -> [2] -> [3]

Ou seja, o primeiro valor encadeia o segundo que encadeia o terceiro, obrigatoriamente precisando ter a leitura completa da lista por um
exemplo para acessar o valor [3];

### AÇÕES POSSÍVEIS NA LISTA

- Variada:

```elixir
    Input: [1, 2 , 3.5, "string"]
    Output: [1, 2, 3.5, "string"]
```

- Somada/Concatenada:

```elixir
    Input: [1, 2, 3] ++ [4 ,5, 6]
    Output: [1, 2, 3, 4, 5, 6]
```

- Substraída:

```elixir
    Input: [1, 2, 3] -- [2]
    Output: [1, 3]
```

- Acesso de elementos:

```elixir
    hd (retorna a cabeça, ou seja, o primeiro elemento da lista):
        Input: hd([1, 2, 3])
        Output: 1

    tl (retorna a cauda, ou seja, todos os elementos da lista menos o primeiro):
        Input: tl([1, 2, 3])
        Output: [2, 3]
```

### IMUTABILIDADE EM LISTAS

A seguinte operação:

```elixir
    x = [1, 2, 3]
    x = [1, 2, 3] ++ [4]
```

O que acontece aqui ?

Nós estamos fazendo uma concatenação/soma da lista [1, 2, 3] e [4], porém, o processo final não irá fazer com que o valor original
de X ou até mesmo da lista [4]. Eles permanecem em memória salvos e o novo valor de Output: [1, 2, 3, 4].

Agora o que aconteceu com o novo valor de X ? Ele vai criar outro valor em memória ?

R: Não, ele irá fazer um apontamento para o local de memória de X e de Y e então com o mapeamento da memória somar os concatenar/somar. Então
ele não cria outro espaço em memória para uso mas faz o consumo dos já existentes como se fosse um referência das ações que ocorreram.
Fazendo um trabalho de memória mais inteligente e eficiente.

## TUPLAS

A sintaxe das tuplas é parecida com a de objetos JavaScript tendo o seu início e fechamento identificado pelo colchetes {}.

### DIFERENÇA ENTRE TUPLA E LISTA

A tupla é armazenada contiguamente na memória, ou seja endereços um após o outro seguintes, o que significa que nesse caso temos
acesso direto aos elementos.

Exemplo:

```elixir
    x = {1, 2, 3, 4, 5, 6, 7, 8}
    
    Input: elem(x, 4)
    Output: 5 

    Input_2: put_elem(x, 4, "abacate")
    Output: {1, 2, 3, 4, "abacate", 6, 7, 8}
```

Como os endereços são contiguos em memória, o tamanho da tupla não é dinâmico então não é possível simplesmente
ir acrescentando novos valores, então caso eu faço *put_elem(x, 8, "abacate")* um erro me será gerado pois esse índice não existe nessa tupla;

Sempre que eu precisar acrescentar valores a uma tupla, deve-se criar uma nova tupla;

### IMUTABILIDADE EM TUPLAS

A lista como vimos no exemplo acima ela sempre vai apontar para o local de memória dos valores originais para poder formar o valor esperado, não criando
novos valores em memória.

Agora a tupla, sempre que nós fazemos uma modificação nela, nós estamos criando uma outra tupla em memória com os valores novos. Então por um exemplo:

```elixir
x = {1, 2, 3} -> Tenho uma tupla em memória
put_elem(x, 1, "abacate") -> Ele vai criar mais uma tupla em memória com o valor {1, "abacate", 3};
```

Agora teremos em memória 2 locais endereçados de tuplas, sendo elas : *{1, 2, 3} e {1, "abacate", 3}*

### CONTEXTO PARA USO DE TUPLAS

Normalmente elas são usadas para efetuar um agrupamento de dados que fazem sentido entre si e que normalmente, não vão ter trabalho em cima deles para modificações extensas
ou trabalho de recursividade/iteração;

Exemplo de uso das tuplas (realizado pelo Elixir):

Vamos imaginar que temos um arquivo *tuplas.txt* esse arquivo possui um conteúdo *texto de teste muito testador*.
Agora imaginemos que precisamos recuperar o conteúdo desse arquivo, podemos usar a seguinte linha de código:

```elixir
    Input: File.read("tuplas.txt")
    Output: {:ok, "texto de teste muito testador"}
```

É possível identificar que ele nos retorna uma tupla com agrupamento de dados que fazem sentido entre si, tem um ATOM :ok, indicando que a recuperação foi um sucesso
e o conteúdo desse arquivo txt

## TUPLAS VS. LISTAS PARA RETORNOS

Tuplas: Normalmente as utilizaremos para retorno de funções, onde normalmente vamos retornar em primeiro indice um atom indicando sucesso ou não da função e nos demais
parâmetros os valores trabalhados e/ou retornados da função.

Listas: Normalmente iremos as utilizar para trabalhar uma grande quantidade informação de forma encadeada e com apontamento para locais de memória já estabelecidos, então
podemos as usar por um exemplo em retornos de API's.

## MAPS

Maps são estruturas de dados usadas para termos acesso aos valores de uma tupla pelo modelo *chave => valor (acesso direto)*.

Sintaxe do map:

```elixir
%{a: 1, b: 2, c: 3} : os ATOM no map são usados como chave dos valores.

ou

%{"a" => 1, "b" => 2, "c" => 3} : simulando a sintaxe existente no PHP para arrays.
```

E existe diferença nas formas de criação de um mapa ? Sim, a diferença não é no processamento mas sim como é realizado o acesso.

Exemplo:

```elixir
Input Atom: 
    map_atom = %{a: 1, b: 2}
    map_atom.a
    map_atom[:b]
Output Atom: 
    1
    2

Input String:
    map_string = %{"a": 1, "b": 2}
    map_string["a"]
    map_string["b"]
Output String:
    1
    2
```

Não é possível no map de string fazer o acesso direto pela notação *ponto*, diferentemente do map de atom.

Uma forma de adicionarmos valores ao map antes inexistentes é com utilizando o Map.put exemplo abaixo:

```elixir
Input: 
    x = %{a: 1, b: 2}
    x = Map.put(x, :c, 3)
Output:
    %{a: 1, b: 2, c: 3}
```

No MAP temos algumas formas de fazer uma alteração dos valores existentes nele como demonstrado abaixo:

```elixir
1ª forma
    Input:
        x = %{a: 1, b: 2, c: 3}
        Map.put(x, b:, 2.2)
    Output: %{a: 1, b: 2.2, c: 3}

2ª forma
    Input:
        x = %{a: 1, b: 2, c: 3}
        %{x | b : 2.2}
    Output:
        %{a: 1, b: 2.2, c: 3}
```

É possível existir listas e maps junto ?

R: Sim, é perfeitamente possível e comum, principalmente quando trabalhos com JSON usado em requisições web e em comunicações com API's
Onde nós teremos uma lista de maps.

Exemplo de como pode ser uma lista de maps:

```elixir
[
    %{nome: "Gustavo", idade: 23},
    %{nome: "Joao", idade: 30}
]
```

## PATTERN MATCHING

O que é ?
    Match é o esquema de atribuição de valores as variáveis trabalhado pelo Elixir. Diferente de uma PHP ou JavaScript da vida,
    o Elixir não irá simplesmente atribuir o valor a variável, ele vai fazer uma operação funcional desse valor.

Então no exemplo a seguinte onde fazemos *x = 4* nós sabemos que em PHP nós estamos atribuindo o valor 4 a variável X, em Elixir
ele vai fazer o seguinte: Para que essa expressão seja verdadeira, ou seja, que X seja de fato verdadeiro com 4 eu devo dizer
que o X tem o valor de 4, então ele entrega ao X o valor necessário para dar Match com o 4.

Se por um acaso nós realizar o match *x = 4* e posterior a fazer fazer a comparação *5 = x*, ele vai dar um erro de Match,
pois o valor de 4 foi dado a X para que ele se compare a uma operação verdadeira no momento de Match/Atribuição da variável.

Ok, a ideia é diferente, porém, o resultado final entregue é o mesmo... Então qual é a diferença ? (Resposta em estudo)
