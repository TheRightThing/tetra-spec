# Tetra-Spec

## Components
* Code-Components
* Spec-Components
* Visual-Components

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
For each tagname can be defined which value it holds.
Think of Golangs \`\` annotation system e.g.
`json` which allows stuff like this:

```Go
type A struct {
  some int `json:some`
}
```
Just better.

## Labels
Self-clearing tags on instantiation.

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

## New way of coding
* Non-linear code.
* Lazy
* Currying
* Multiparadigm
