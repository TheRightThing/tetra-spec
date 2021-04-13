# Types

## Problems
How to guarantee exclusive ownership, so that the compiler is able to act accordingly.
How to guarantee an execution context? <-

## Answer
Enable developers to express ownership exclusivity and [(owner-constraints/contexts)] in the typesystem by supplying families? of classes/types as a type parameter.

```tetra

type IntStringOwner struct {
    // something
}

b: Int[unique<IntOwner>] = 42

func (i IntStringOwner) consume(a: Int[unique,<IntOwner>], b: StringOwner, c: String[unique,<StringOwner>]) { /* unique constrained ownership */ }
// equivalent to:
func (i IntStringOwner) consume(a: Int[unique], b: StringOwner, c: String[unique]) { /* unique ownership */ }

func (i IntStringOwner) consume(a: Int[<IntOwner>], b: StringOwner, c: String[<StringOwner>]) { /* constrained ownership */ }

// custody passing:
v: [Int[unique<IntOwner> custody]]Collection

```
**Note**: Syntax is subject to change

**Split constrained ownership and unique ownership.**
