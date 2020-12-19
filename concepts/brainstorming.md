# General Remarks
* Include patter matching.
* Decorate ADTs (Algebraic Data Types/Unions).
* Keep thinking about total/partial functions (and arising problems).

# Switch & Pattern Matching
* `switch` to express both.
* Excplicit fall-through.
* Standard `switch` acting total (on types && values):
  * Only allow `default` with a body unless specifically specified.
  * Partial switch which does not allow a `default` case:
    * 1. Either with implicit `default` doing nothing.
    * 2. Implicit `default` with error behaviour (throwing Exceptions/return Error).

```
1. Ignore Error -> Explicit => Noop     // like try-catch with empty catch-clause <- taggen
2. Exception Trace                      // Good Debugging Error (ln, statement) <- default
3. Return undefined                     // Cheaper than 2.  <- taggen
```
Allow defined token behaviour of 1. and 3. also in `switch`.
* For partial `switch` use different style of brackets (`[]`) and `token` to define behaviour. (3.)

> An empty default is the poor mans totality

# Coroutines
* Make async behaviour excplicit.
* Give hint to function signature:
  * No unknown template member functions => constrained templates:
    * Only make members of template types accessible via constraint types.

``` Tetra
@ == coroutine

function(f: ((int, int) @? int)) @? float := float(f(1,1))/2;
```

* Do not expose await calls for std threads (no OS level blocking).
* Two calling conventions for coroutines where:
  * 1. **conf async**, execute until first yield (default)
  * 2. **full async**, directly queue to scheduler.

# Generators
* Not implemented by abusing coroutines, but rather separate language construct.

``` Tetra
ip == inputfeed // generator, i-connection, filestream

FOR v IN in {
  // use v
}
```

``` Not Tetra

\forall e in A -> \exists x in B
not \forall e in A -> \exists x in B

iter = open.file.iter

for iter.Next {
  iter.fetch -> use value
}

[1,2,3,4,5].Iterator()

for Iter.Next() {
  patter_match body {
    1
    2
    3
    4
    default/error:
      {}
  }
}
```

```

// Composition
type U = A | B | C | D

f :: U -> H
f A
f B
f C
f D

f :: U -> H
f A
f _

f :: U -> H
f A

type EvenNumbers

g :: Integer

h :: Integer
h Integer = {
    FOR el IN m {
      (Integer) -> //
      (Float) -> //
      _ -> Error
    }
    
    match(m[key]) {
      (Integer) ->  //
      (Float) ->  //
      (UnionType) ->  // pattern
      (Point{5, Y, Z, ...} =| let p <-Point.X == 5) -> // p.Y
    }
    
    // Pattern Matching (Type?-Level) && Destructuring of Composed Types
    f :: Integer -> Bool
    f 5 = { true }
    f x = false
    
    
    evaluate :: (OPCODE)
    evalute OPCODET
}

```
