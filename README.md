# provenance

A dynamic programming helper library. It provides some simple APIs to mutable 2 dimensional arrays using `Data.Vector.Mutable` from the `vector` package.

This is essential for **BOTTOM UP** dynamic programming. It is fairly well documented to use laziness and other fancy tricks for memoized top-down dynamic programming in Haskell.

```haskell
make_matrix :: a -> Int -> Int -> m (MVector (MVector a))

read_matrix :: MVector (MVector a) -> Int -> Int -> m a

write_matrix :: MVector (MVector a) -> Int -> Int -> Int -> m ()

m can be either IO or ST depending on your use case.
```

Taken from here : http://www.seas.upenn.edu/~cis552/current/lectures/soln/STMonad.html

The library also contains solutions to various dynamic programming problems in a bottom up style.
