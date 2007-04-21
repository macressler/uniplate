
module Generate(generateExpr, generateStm) where

import Data
import Control.Monad
import System.Random
import Test.QuickCheck


generateExpr :: Int -> IO [Expr]
generateExpr n = generateList n

generateStm :: Int -> IO [Stm]
generateStm n = generateList n


generateList :: Arbitrary a => Int -> IO [a]
generateList n = replicateM n (newStdGen >>= \x -> return $ generate 7 x arbitrary)


{-
generateOne :: IO Expr
generateOne = f 0
    where
        f depth = do
            choice <- getStdRandom (randomR (0,5))
            cutoff <- getStdRandom (randomR (0,20))
            if choice <= 0 || cutoff < depth then do
                i <- getStdRandom (randomR (-999,999))
                return $ Val i
             else do
                a <- f (depth+1)
                b <- f (depth+1)
                return $ case choice of
                    1 -> Neg a
                    2 -> Add a b
                    3 -> Sub a b
                    4 -> Mul a b
                    5 -> Div a b
-}

instance Arbitrary Char where
    arbitrary = choose ('a','z')
    coarbitrary = undefined

instance Arbitrary Expr
    where arbitrary = do x <- choose (0, 10)
                         case x of
                             _ | x <= 2 -> do x1 <- arbitrary
                                              return (Val x1)
                             _ | x <= 5 -> do x1 <- arbitrary
                                              return (Var x1)
                             6 -> do x1 <- arbitrary
                                     return (Neg x1)
                             7 -> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (Add x1 x2)
                             8 -> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (Sub x1 x2)
                             9 -> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (Mul x1 x2)
                             10-> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (Div x1 x2)
          coarbitrary = error "coarbitrary not yet supported"



instance Arbitrary Stm
    where arbitrary = do x <- choose (0, 3)
                         case x of
                             0 -> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (SDecl x1 x2)
                             1 -> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (SAss x1 x2)
                             2 -> do x1 <- arbitrary
                                     return (SBlock x1)
                             3 -> do x1 <- arbitrary
                                     return (SReturn x1)
          coarbitrary = error "coarbitrary not yet supported"



instance Arbitrary Exp
    where arbitrary = do x <- choose (0, 5)
                         case x of
                             0 -> do x1 <- arbitrary
                                     return (EStm x1)
                             1 -> do x1 <- arbitrary
                                     x2 <- arbitrary
                                     return (EAdd x1 x2)
                             _ | x <= 3 -> do x1 <- arbitrary
                                              return (EVar x1)
                             _ -> do x1 <- arbitrary
                                     return (EInt x1)
          coarbitrary = error "coarbitrary not yet supported"



instance Arbitrary Var
    where arbitrary = do x1 <- arbitrary
                         return (V x1)
          coarbitrary = error "coarbitrary not yet supported"



instance Arbitrary Typ
    where arbitrary = do x <- choose (0, 1)
                         case x of
                             0 -> return T_int
                             1 -> return T_float
          coarbitrary = error "coarbitrary not yet supported"



