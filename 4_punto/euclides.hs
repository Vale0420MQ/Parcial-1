module Main where

import Data.Time.Clock (getCurrentTime, diffUTCTime, NominalDiffTime)
import System.IO (hSetBuffering, stdout, BufferMode(..))

gcd' :: Integer -> Integer -> Integer
gcd' a 0 = a
gcd' a b = gcd' b (a `mod` b)

-- Pares de prueba
testPairs :: [(Integer, Integer)]
testPairs =
    [ (48,          18)
    , (100,         75)
    , (1071,        462)
    , (1000000,     999999)
    , (123456789,   987654321)
    , (999999937,   999999893)
    ]

-- Repite el calculo n veces y devuelve tiempo en ms
benchmark :: Integer -> Integer -> Int -> IO Double
benchmark a b reps = do
    start <- getCurrentTime
    let results = replicate reps (gcd' a b)
        !total  = foldl (+) 0 results   -- fuerza evaluacion
    end <- getCurrentTime
    let diff = realToFrac (diffUTCTime end start) * 1000 :: Double
    return (diff / fromIntegral reps * 1e6)   -- ns por llamada

main :: IO ()
main = do
    hSetBuffering stdout LineBuffering

    putStrLn $ padR 25 "a" ++ padR 25 "b" ++
               padR 10 "GCD" ++ padR 15 "Tiempo (ns)"
    putStrLn $ replicate 75 '-'

    mapM_ (\(a, b) -> do
        t <- benchmark a b 100000
        putStrLn $ padR 25 (show a) ++ padR 25 (show b) ++
                   padR 10 (show (gcd' a b)) ++
                   padR 15 (show (round t :: Int))
        ) testPairs

    putStrLn "\n--- Precision arbitraria (imposible en C con long long) ---"
    let bigA = 123456789012345678901234567890 :: Integer
        bigB = 987654321098765432109876543210 :: Integer
    putStrLn $ "GCD(" ++ show bigA ++ ","
    putStrLn $ "    " ++ show bigB ++ ")"
    putStrLn $ "= " ++ show (gcd' bigA bigB)

  where
    padR n s = s ++ replicate (max 0 (n - length s)) ' '