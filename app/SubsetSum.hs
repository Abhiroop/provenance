module SubsetSum where

import DArray
import Control.Monad(forM_)
import Data.List (length)
import Data.Vector(fromList, (!))

import Control.Monad.ST
-- Given a set of non negative numbers and a target it tells whether it is possible to have a subset which sums up to a target

-- Eg: [2,3,7,8,10] and target = 11 it is possible with 8 and 3

subsetSum :: [Int] -> Int -> ST s Bool
subsetSum input target = do
  let l = length input
      inp = fromList input
  m <- make_matrix False (l + 1) (target + 1)
  forM_ [0 .. l] $ \i -> do
    write_matrix m i 0 True

  forM_ [1 .. l] $ \i ->
    forM_ [1 .. target] $ \j -> do
      a <- read_matrix m (i - 1) j
      b <- read_matrix m (i - 1) (j - (inp ! (i - 1)))
      if (j >= inp ! (i - 1)) then
        write_matrix m i j (a || b)
      else
        write_matrix m i j a
  result <- read_matrix m l target
  return result
