# Tetra-Spec

## Components
* Code-Components
* Spec-Components
* Visual-Components

## Syntax & Semantics & Language
* Specific syntax for code to describe "I don't care how, but do it best for target".
* Procedures, Functions:
  * Useful to distinguish procedures and functions?
* **We will not assume to compile to a virtual (sequential) processor**
* Every component might be a statemachine.
* The whole state of a program is aggregation of all components.

### Keywords
* **Concept**:
  * Defining (multiple) function signatures for a type.
  * Similar interfaces in Go or Typeclasses in Haskell.
* **Mask**
  * See (rmbrt-lang)[https://github.com/RmbRT-lang/std/blob/master/std/io/stream]
  
  class Connection {
    connect() {};
    disconnect() {};
  }

  Mask isConnection {
    connect();
    disconnect();

    someState s;
  }
* Sum and Product types.
* Structured `enums`.

      data Cool = A | B | C | D
      data YAY = YAY {...}
      r name(params) r {}

**Declaration**:
  
    NAME : TYPE (ARGS)
    NAME ::= EXPR
    NAME(ARGS) RETURNT

    // Abbreviate
    NAME(ARGS) TYPE = EXPR
    NAME(ARGS) = EXPR

    (TYPE::(ARGS) RET) *
    ((ARGS) RET) *
    (VOID::(ARGS) RET) *

    // Currying
    NAME : ARG1..N > RET

    NAME(a, b, c, d) TYPE = EXPR

    fn ::= NAME(a)
    fn // NAME(b,c,d) RETURNT

    f :: Int -> Bool -> String
    h :: String -> Bool -> Int

    g = f o h "text" // g :: Bool -> Int -> Bool -> String

### Semantics: New way of coding
* Non-linear code.
* Lazy
* Currying
* Multiparadigm
* Going **hardware**:
  * Program & Hardwaredesign describing with same code.
  * Eventdriven execution:
    * Global/Member processes, Coroutines bound to lifetime of some instance.
    * Free or bound member callbacks.
  * Native support for Events &&/|| pipes and user definable:
    * Look at `C signals`.
  * Synchronization primitives embedded in language and user definable.
  * Differentiate between functional/combinatorical and sequential logic:
    * Simultaneous/Sequential logic.
    * Transactional blocks (block of instructions) which ends when all instructions were executed.
    * Parallel `for` loops.
  * **Causality graphs** or **data flows** as part of doc with the help of annotations.

## IDE
* Like black box parts of a electric circuit for components.
* Use gestures for syntax constructs:
  * How do we revolutionise code creation?

## Tag
Contextual changes for types and functions:
* Debugging
* Compiling/Optimisation
* Profiling
* Guarantees
* Called in code-generation:
  * Allowing for intercommuncation between tag instances/evaluation/execution when code is generated.
  * _Hooks_ for invariants e.g. start/end of a function.
 
### Annotations
Tagnames have to refer to code-entities.
Can hold values.
Give context for whole module, please do not think of a single file (: thx.
For each tagname can be defined which value it holds.
Think of Golangs \`\` annotation system e.g.
`json` which allows stuff like this:

    type A struct {
      some int `json:some`
    }
  
Just better.

## Labels
Self-clearing tags on instantiation.
Do not propagate.

## Layer
Each layer one would want to reason about program code.
* Concurrency/Causality:
  * Timeline
  * Effects
  * Visibility
* Optimisation
* Specification:
* Liveness invariants
Deduced from code-analysis.
* Deadlock & Liveness detection:
  * For detection purposes:
    * Is at least one event being processed currently?

## Currying
* Lazy type-specifier?

## Compiler
* Tetra -> C => LLVM => Bytecode.
* Include Tests and Assertions directly in the language:
  * Debug- & Release-Assertions included.
* Generic mode which tries to "act" upon the given compile target.
  * Target dependent implementations (overloading).

## Which language to use for compiler
* Glorious Haskell.

## SIMD
* Apply simultaneous/parallel execution.
* Derive SIMD applicability by investigating constraints:
  * Have simple rules in language, which allow to derive applicabilty for SIMD.
* _reference Going Hardware Section_
 
## Consistency:
* Understand relaxed, causal, sequential consistency.
* Consistency either for `operations` or `variables`:
  * Variable: could be tagged as `eventually` consistent.
* **Atomics**:
  * Native support

## Support for TCO
* Differentiate between destructors and clean-up operations:
  * Add Hooks:
    * **out of scope**
    * **last usage**
* **Relaxed RAII like construct**

## FOR | WHILE | SWITCH Constructs
**Might be obsolete**
* Make them "self-definable"?
* Might use tags:
  * e.g. can define scheduler for `for` loops.

## Test
* **Test-Keyword**
* **Mocking-Keyword**:
  * Inject mock-behaviour/mock-values into existing objects.
  * Maybe for return values?
  * Returns mock-default of return type.
* Better-Monkey-Patching -> Go hand in hand with tags.
* Mutation-testing via Monkey-Patching or similar?
* **Generalized tests**:
  * Attach to some interface or similar, so everything implementing this
    interface can automatically be executed by the test and have a generalized
    testcase derived (also applies to concepts).
  * Attached generalized tests can provide additional interfaces, which have to
    be implemented by the underlying implementation of the parent-interface.
    * Add more functions like constructors which have to be supplied to allow
      instantiation of tested types/variables.
  * Similar to generators used in property testing.
* **How to support Test-Driven-Design**:
  * TBD

## Error-Handling
* Maybe move to different layer?
* Should not impact function signature, nor caller code:
  * Signature still has a "hint" describing **THAT** some error might occur,
    but not how. I.e. it does not matter for the developer if the function
    throws, errors whatever.
* **Need more thoughts/ideas**

## Levitating ideas
* Serdhrapl nanylfvf sbe pbapheerapl ceboyrzf
