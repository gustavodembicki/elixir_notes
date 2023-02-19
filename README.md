# ANOTAÇÕES DE ESTUDO SOBRE ELIXIR

## **CONCEITO DA LINGUAGEM**

REVER

&nbsp;

## **COMANDOS IMPORTANTES**

No terminal do elixir, pode usar comandos como: **Map. (TAB)**

O que isso faz ?
> Lista uma documentação para nós, das funções de Map padrões da linguagem e o mesmo para >List e para todas as outras funções da linguagem como String, Float, Integer, Atom, etc.

&nbsp;

## **TIPOS PRIMITIVOS (BOOLEAN | STRING | FLOAT | INTEGER)**

REVER

&nbsp;

## **LISTAS**

Diferentemente das outras linguagens, no **Elixir** as listas trabalham com ***encadeamento***, e por que isso ?

Bom, listas encadeadas não permitem um acesso direto aos valores armazenados na memória. E caso seja necessário acessar o segundo valor dessa lista, é obrigatório passar pelo primeiro índice da lista pois existe a seguinte ordem de execução:

```elixir
[1] -> [2] -> [3]
```

Ou seja, o primeiro índice é o responsável por encadear os demais e gerar a possibilidade de os acessar. Sem passar pelo primeiro não temos como validar o valor do segundo/terceiro índice e assim por diante.

&nbsp;

Uma lista pode conter valores:

1. Variados:

    ```elixir
    Input: [1, 2 , 3.5, "string"]
    Output: [1, 2, 3.5, "string"]
    ```

2. Somado/Concatenado:

    ```elixir
    Input: [1, 2, 3] ++ [4 ,5, 6]
    Output: [1, 2, 3, 4, 5, 6]
    ```

3. Substraída:

    ```elixir
    Input: [1, 2, 3] -- [2]
    Output: [1, 3]
    ```

&nbsp;

E como seria um exemplo de acesso/verificação dos elementos de uma lista?

```elixir
hd (retorna a cabeça, ou seja, o primeiro elemento da lista):
    Input: hd([1, 2, 3])
    Output: 1

tl (retorna a cauda, ou seja, todos os elementos da lista menos o primeiro):
    Input: tl([1, 2, 3])
    Output: [2, 3]
```

&nbsp;

### *IMUTABILIDADE EM LISTAS*

Como funciona a imutabilidade do **Elixir** nas listas ?  

&nbsp;

Para poder responder a pergunta de forma mais didática, vamos levar em consideração o código abaixo:

```elixir
x = [1, 2, 3]
x = [1, 2, 3] ++ [4]
```

O que acontece aqui neste código?  
Nós estamos fazendo uma concatenação/soma da lista ``[1, 2, 3]`` e ``[4]``. O que vai acontecer nesse caso ? Em memória, nós teremos 2 listas criadas, a lista de X e ``[4]``, eles não sofrerão alteração, o que vai acontecer é:
> Um apontamento para o local de memória de X e de ``[4]`` e então com a leitura da memória realizada, somar/concatenar os valores. Não criando outro espaço em memória para uso, mas fazendo o consumo dos dados já existentes como uma referência em memória, sendo um trabalho de memória mais performático.

&nbsp;

## **TUPLAS**

A sintaxe das tuplas é parecida com a de objetos JavaScript tendo o seu início e fechamento identificado pelo colchetes {}.

&nbsp;

### *DIFERENÇA ENTRE TUPLA E LISTA*

A tupla é armazenada contiguamente na memória, ou seja endereços um após o outro, o que significa que nesse caso temos
acesso direto aos elementos.

```elixir
É possível acessar diretamente o valor da seguinte forma :
    Input: 
        x = {1, 2, 3, 4, 5, 6, 7, 8}
        elem(x, 4)    
    
    Output: 5 

É possível também alterar o valor de um índice específico da tupla :
    Input:
        x = {1, 2, 3, 4, 5, 6, 7, 8}
        put_elem(x, 4, "abacate")
    
    Output: {1, 2, 3, 4, "abacate", 6, 7, 8}
```

Como os endereços são contiguos, o tamanho da tupla não é dinâmico. Portanto, não podemos simplesmente ir acrescentando novos valores, então no exemplo:  

```elixir
x = {1, 2, 3}
put_elem(x, 8, "abacate")
```  

Um erro será gerado pois esse índice não existe nessa tupla.
> Sempre que for necessário acrescentar valores a uma tupla, deve-se criar uma nova.

&nbsp;

### *IMUTABILIDADE EM TUPLAS*

A lista como exemplificado acima ela sempre vai apontar para o local de memória dos valores originais e então gerar o valor esperado, não criando novos valores em memória.

Ja a tupla trabalha de outra forma, sempre que é realizada uma modificação, é criada uma nova tupla em memória com os valores modificados. Então por um exemplo:

```elixir
x = {1, 2, 3}
put_elem(x, 1, "abacate")
```

Agora existe em memória 2 locais endereçados de tuplas, sendo elas : ``{1, 2, 3}`` e ``{1, "abacate", 3}``

&nbsp;

### *CONTEXTO PARA USO DE TUPLAS*

Normalmente elas são usadas para efetuar um agrupamento de dados que fazem sentido entre si e que normalmente, não vão ter processamentos em cima para modificações extensas ou processo de recursividade/iteração;

&nbsp;

Exemplo de uso das tuplas:

Vamos imaginar que temos um arquivo **tuplas.txt** esse arquivo possui como conteúdo **texto de teste muito testador**.
Agora precisamos recuperar o conteúdo desse arquivo:

```elixir
Input: File.read("tuplas.txt")
Output: {:ok, "texto de teste muito testador"}
```

É possível verificar que ele nos retorna uma tupla com agrupamento de dados que fazem sentido entre si, tendo um *atom* ``:ok``, indicando que a recuperação foi um sucesso
e o conteúdo desse arquivo txt.

&nbsp;

## **TUPLAS VS. LISTAS PARA RETORNOS**

*Tuplas*: Normalmente as utilizadas para retorno de funções, onde é retornado em no 1º indice um *atom* indicando ``:error`` ou ``:ok`` (valores ilustrativos, não sendo regra absoluta) e nos demais parâmetros os valores trabalhados e/ou retornados da função.

*Listas*: Normalmente utilizadas para processar uma grande quantidade informação de forma encadeada e com apontamento para locais de memória já estabelecidos, podendo ser modificadas sem causar um alto consumo de memória.

&nbsp;

## **MAPS**

Maps são estruturas de dados usadas para acesso aos valores de uma tupla pelo modelo *chave => valor (acesso direto)*.

Sintaxe do map:

```elixir
%{a: 1, b: 2, c: 3} : os ATOM no map são usados como chave dos valores.

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

> Não é possível no map de string fazer o acesso direto pela notação *ponto*, diferentemente do map de atom.

&nbsp;

Uma forma de se adicionar novos valores ao map antes é utilizando o **Map.put**:

```elixir
Input: 
    x = %{a: 1, b: 2}
    x = Map.put(x, :c, 3)
Output:
    %{a: 1, b: 2, c: 3}
```

No **Map** existem formas de alterar os valores existentes como demonstrado abaixo:

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

&nbsp;

É possível existir listas e maps junto ?

Sim, é perfeitamente possível e comum, principalmente com JSON (JavaScript Object Notation) usado em requisições web e retornos de API's
Onde nós teremos uma lista de maps.

Exemplo de uma lista de maps:

```elixir
[
    %{nome: "Gustavo", idade: 23},
    %{nome: "Joao", idade: 30}
]
```

&nbsp;

## **PATTERN MATCHING (EM PROGRESSO)**

O que é ?
    Match é o esquema de atribuição de valores as variáveis trabalhado pelo Elixir. Diferente de uma PHP ou JavaScript da vida,
    o Elixir não irá simplesmente atribuir o valor a variável, ele vai fazer uma operação funcional desse valor.

Então no exemplo a seguinte onde fazemos *x = 4* nós sabemos que em PHP nós estamos atribuindo o valor 4 a variável X, em Elixir
ele vai fazer o seguinte: Para que essa expressão seja verdadeira, ou seja, que X seja de fato verdadeiro com 4 eu devo dizer
que o X tem o valor de 4, então ele entrega ao X o valor necessário para dar Match com o 4.

Se por um acaso nós realizar o match *x = 4* e posterior a fazer fazer a comparação *5 = x*, ele vai dar um erro de Match,
pois o valor de 4 foi dado a X para que ele se compare a uma operação verdadeira no momento de Match/Atribuição da variável.

Ok, a ideia é diferente, porém, o resultado final entregue é o mesmo... Então qual é a diferença ? (Resposta em estudo)
