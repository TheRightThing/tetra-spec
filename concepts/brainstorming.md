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

```Tetra
@ == coroutine

function(f: ((int, int) @? int)) @? float := float(f(1,1))/2;
```

* Do not expose await calls for std threads (no OS level blocking).
* Two calling conventions for coroutines where:
  * 1. **conf async**, execute until first yield (default)
  * 2. **full async**, directly queue to scheduler.

# Generators
* Not implemented by abusing coroutines, but rather separate language construct.

```Tetra
ip == inputfeed // generator, i-connection, filestream

FOR v IN in {
  // use v
}
```

```Not Tetra
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

# Throwables
* Traced:
    -> Tuple with field for Stacktrace
* Untraced:
    -> Single field

# Compiling
* Parallelizing compilation.
* Feature for parallelizing stuff within a single file:
    * Should be possible with our scoping system.

# Typesytem

## Typedecorations:
* Pattern-Matchable.
* Remark: Globally defined.
* How to handle tagged types, which form a superset to untagged types?:
* E. g. tagged pointer used as a param for untagged pointer.
* How to guarantee possible contraints.
* Like `typedef`, custom typedecoraters can be specified:
  * Not global, but accessible by scope.
  * First does matching against itself and then, if not successful, match against expanded definition:
    * E.g. custom typedecorater `sharedPtr ::= :gc | :shared`.
    * First match against `sharedPtr`, then `:gc | :shared`.
* List of **irreconcilable** decorators for types.

## Typed Enums
```
// We do not want this:

enum Token {
  COMMA,
  DOT,
}

c :: Token -> String
c COMMA = ","
c DOT = "."

// We want this:

class Person {}

enum Employee -> Person {
  Manager: Person(constructorparamsManager),
  Pleb: Person(constructorparamsPleb),
}

enum Token -> String {
  COMMA: ",",
  DOT: ".",
}

// For bijective mapping only possible iff BASECLASS instance of Ord &&/|| Eq.
enum NAME -> BASECLASS {}
```

# Namespacing
* Can be extended by using the same namespace in different source files.
* `private` for namespacing.
* `import` via files:
  * How would one handle interpreters "conveniently".
* Settle on `private` keywords for namespace visibility (`public` per default):
  * Note: Complex libraries/projects requiring distributed namespaces over multiple files should use a dedicated "exportheader".
* Every file would have `export *` implicitly.
* For export file one would explicitly say: `export // define detailed exports`.
* Access to namespaces with the `NAMESPACE::NAMESPACE` operator.
```
// in the following `::` = `namespace`

// file03
importprotected as Z from "file01";
::Y {
  X.f2()
}

// file01
::X {
  class C1 
  function f1() {}
  function f2() {}
  function private f3() {}
}

// file02
import from "file01";
::X {
  function f4() {}
  function f3() {}
}
```

# Keywords
`private` for namespacing.
`private` for class visibility.
`import` for imports.
`import*` for imports which also reexport everything imported.
`export` for defining WHAT to export from a file.

# Integerconstants
* Per default infinite precision integer:
  * Implies that bitrotates for shifting is useless.

# Functions and Methods
* Different parentheses to distinguish between function call `[]` and compound expressions `()`.
* Goal: Possibly reduce amount of paretheses needed:
```Tetra
// Function call with evaluated args.
f 1 2

// Function call with nested function calls and compound expression.
f [g 1 2, 420] == f (g 1 2) 420 == f [(g 1 2), 420]

// Multiple nested function calls and compound expressions.
// case of f == (+) && h == (-)
g [f 1 2, h 4 5] == g [(f 1 2), (h 4 5)] == g 3 (-1)
```
* Index lookup for container types are equivalent to function calls `[]`, so there is no ambiguity.
* Note prefix curly braces for template arguments.
```Tetra
c: {Int}IndexableContainer
f c[2] == f (c 2) == f [c[2]] == f [(c[2])] == ...

{T} fun [a: int, b: bool, c: container, anonymType] {int}Vector [ 
  if (expr) [
    return 420
  ] else [
    return 69
  ]
  
  if (expr)
    return 420
  else
    return 69
    
  // partial
  switch [variable] [
    case1:
    case2:
    caseN:
  ]
  
  switch (variable) [
    case1:
    case2:
    caseN:
    default:
  ]
  
  while (expr) [ // body ]
  
  // == -> equals
  // := -> assignment
  // ::= -> autovariable
  for (v ::= 0; cond_expr; expr) [ // body ]
  
  do (// optional variable) [ // body ] for (cond_expr; expr)
]
```
* TODO: semantics add do-for.

## Templates and Constraints
```
[T: TYPE(Constraint1,...,ConstraintN), U: TYPE]
[I: NUMBER]
[T: TYPE, Order: (T, T -> Signed)] Set {...}
```

## Foreign Function Interface (FFI)
* In case of user space scheduling, foreign functions need to be executed in a extra thread:
  * Some languages might already support this behaviour, which can be expressed in the FFI interface implementation.
  * FFI tagging in interface implementation to describe potentially `heavy/light` (long/short running) workloads?
```
| ^^^^^^^^  |
| some lang |
| _________ |
      |
      v
| ^^^^^^^^^^^ |
| impl FFI    |
|-------------|
      |__ c-extension __
                        |
                        v
                  | ^^^^^^^ |
            ----> | Tetra-C |
      .____/      |---------|
      |
      |
| ^^^^^^^^  |
| Tetra-Src |
| _________ |
```
* Concrete FFI:
  * Support required calling conventions within compiler when code is generated.

### External language binding generators, e.g.:
```C
void f(int i) { // body }
```
```Tetra
// Should be usable as if it was a native tetra function.
f 420
```
* What about foreign structs/classes/datatypes...:
  * Padding alignment differs from language to language.
  * Pointersizes.
  * Tetra types -> Foreign types:
    * E.g. unbounded/bounded ints.
    * most likely handled by custom defined conversion operators.
  * Tetra abstractions <-> Foreign abstractions:
    * E.g. Golang style interfaces, C++ con-/destructor.

## Hardware-Module interop
* TODO

## Notes
* Separation of declaration and definition:
  * Do not support, rather force rethinking/redesigning...

## Destructuring
type ErrorInterface a => (MathEnv a)

type State = {
  StateOfEnv
  vars :: [strings]
}

f :: (a, b, c) -> MathEnv

g :: (a MathEnv) -> Void
g (MathEnv ERROR) -> do ...
g (MathEnv with NULL in vars) = do ...
g a = do ...

type NumFrom0To5 = ZERO | ONE | TWO | THREE

[meGo] <- mock go style Xd.
y :: Number -> Void
y n = do ...
y m = do ...

[exhaustive]
x :: NumFrom0To5 -> Void
x ONE | TWO = do ...

--------------------  <- exhaustive check needed for input (optional).

// compiler warns dev about missing cases.
x a = do ...
x _ = throw

Performance wise "good" implementation with extra information from callerside.
Performance by hashable types for map-lookups, switching.
Might be unified with the concept of **GUARDS**.

## Casting and Masks
* **ABSTRACT CAST** used in abstract classes and used for converting things into **Masks**.
* Deriving of Masks for classes should be handled implicitly by the compiler.
