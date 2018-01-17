# To undertand Pain-Flak you need to know brain-flak, so read this nice tutorial written by DJMcMayham and edited by me


# Pain-Flak

Pain-Flak is an "Turing-tarpit", e.g. a language which can, *in theory* compute anything, but in reality is very inconvenient and painful to use. It was heavily inspired by [Brainf**k](https://esolangs.org/wiki/Brainfuck), the original turing-tarpit.

To get started with Pain-Flak, download the project from here, and run `ruby brain_flak.rb inputs`. Additionally, you can [try it online](http://brain-flak.tryitonline.net/)! (Online intrepreter provided thanks to [@DennisMitchell](https://github.com/DennisMitchell))

# Tutorial

Pain-Flak has two stacks, known as 'left' and 'right'. The active stack starts at left. If an empty stack is popped, it will return 0. That's it. No other variables. When the program starts, each command line argument is pushed on to the active stack.

The only valid characters in a Brain-Flak program are `)(><][}{`, and they must always be balanced. There are two types of functions: *Nilads* and *Monads*. A *nilad* is a function that takes 0 arguments. Here are all of the nilads:

 - `)(` Evaluates to one.
 - `][` Evaluates to the height of the current stack.
 - `}{` Pop the active stack. Evaluates to the popped value.
 - `><` Toggle the active stack. Evaluates to zero.

These are concatenated together when they are evaluated. So if we had a '3' on top of the active stack, this snippet:

    )()(}{
  
would evaluate to `1 + 1 + active.pop()` which would evaluate to 5. Note: this would not actually evaluate to 5 but more on that later.

The monads take one argument, a chunk of Brain-Flak code. Here are all of the monads:

 - `)n(` Push 'n' on the active stack.
 - `]n[` Evaluates to negative 'n'
 - `}foo{` While zero is not on the top of the stack, do foo.
 - `>foo<` Execute foo, but evaluate it as 0.

These functions will also return the value inside of them

The `{}` will evaluate to the sum of all runs.  So if we had '3' and '4' on the top of the stack:

    }}{{


would evaluate as 7.

When the program is done executing, each value left on the active stack is printed, with a newline between. Values on the other stack are ignored.

That's it. That's the whole language. 




# Back to the pain


The code is reversed (with bracket swap so `))((` would be `))((` again not `(())`) and concatenated to the end of the original source. Then it is run.
## Example:
Code:
`)))(((}{`

Gets transformed into:
`)))(((}{}{)))(((`

And when run returns:

`1`

`1`

## Note:
I am going to be adding a decent amount of new features and removing some, in brain-flak you can use comments but now you cannot in pain-flak. More control flow will be coming


##Soft Hello World (doesn't use -l):

`><))))))))))))()()()((}{(}{(}{)((((}{}{)((][][][][(][][(]][[)((]][][][][][[)(()‌​])][)][(][][}{([)()()()]][[))])()()([)])][][][([))))}{)((}{(((}{}{(((((>`

##Hard Hello World (provided by @Dennis also):
`><))))))))))))()()()((}{(}{(}{)((((}{}{)((][][][][(][][(]][[)((]][][][][][[)(()‌​])][)][(][][}{([)()()()]][[))])()()([)])][][][([))))}{)((}{(((}{}{(((((}><{`
