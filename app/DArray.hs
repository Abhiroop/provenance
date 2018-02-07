module DArray where

import qualified Data.Vector.Mutable as V

make_matrix a n m = V.replicateM n (V.replicate m a)

read_matrix vec i j = do
  m0 <- V.read vec i
  V.read m0 j

write_matrix vec i j x = do
  m0 <- V.read vec i
  V.write m0 j x
