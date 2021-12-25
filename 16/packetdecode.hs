import System.IO.Unsafe

type BitStream = [Int]

bits :: Char -> BitStream
bits '0' = [0, 0, 0, 0]
bits '1' = [0, 0, 0, 1]
bits '2' = [0, 0, 1, 0]
bits '3' = [0, 0, 1, 1]
bits '4' = [0, 1, 0, 0]
bits '5' = [0, 1, 0, 1]
bits '6' = [0, 1, 1, 0]
bits '7' = [0, 1, 1, 1]
bits '8' = [1, 0, 0, 0]
bits '9' = [1, 0, 0, 1]
bits 'A' = [1, 0, 1, 0]
bits 'B' = [1, 0, 1, 1]
bits 'C' = [1, 1, 0, 0]
bits 'D' = [1, 1, 0, 1]
bits 'E' = [1, 1, 1, 0]
bits 'F' = [1, 1, 1, 1]
bits _   = error "not hex, son"

fromhex :: [Char] -> BitStream
fromhex [] = [] -- always do your base case first, kids
fromhex (a:rest) = (bits a) ++ fromhex rest

three :: Int -> Int -> Int -> Int
three a b c = 4 * a + 2 * b + c

four :: Int -> Int -> Int -> Int -> Int
four a b c d = 8 * a + (three b c d)

parseLiteral :: BitStream -> (Int, BitStream)
parseLiteral ints = let
  pl accum (1:a:b:c:d:xs) = pl (16 * accum + (four a b c d)) xs
  pl accum (0:a:b:c:d:xs) = ((16 * accum + (four a b c d)), xs)
  in
    pl 0 ints

data Packet = Packet
  { version    :: Int
  , typeId     :: Int
  , value      :: Int
  , subpackets :: [Packet]
  } deriving (Show)

parseLiteralPacket :: Int -> Int -> BitStream -> (Packet, BitStream)
parseLiteralPacket v t xs =
  let (val, rest) = parseLiteral xs
      p = Packet { version = v, typeId = t, value = val, subpackets = [] }
  in (p, rest)

opPacketCount :: Int -> Int
opPacketCount 0 = 15
opPacketCount 1 = 11
opPacketCount _ = error "No. These should all be bits"

readbits :: BitStream -> Int
readbits xs = let accum a b = 2 * a + b
              in foldl accum 0 xs

parseNPackets :: Int -> BitStream -> ([Packet], BitStream)
parseNPackets 0 bs = ([], bs)
parseNPackets n bs = let
  (p, rest) = parsePacket bs
  (last, rest') = parseNPackets (n-1) rest
  in (p : last, rest')

parseOpPacket :: Int -> Int -> BitStream -> (Packet, BitStream)
parseOpPacket version typeid (0:xs) =
  let count = readbits $ take 15 xs
      remaining = drop 15 xs
      subp = parsePackets $ take count remaining
      rest = drop count remaining
      p = Packet { version = version
                 , typeId = typeid
                 , value = 0
                 , subpackets = subp }
  in (p, rest)
parseOpPacket version typeid (1:xs) =
  let count = readbits $ take 11 xs
      (subp, rest) = parseNPackets count $ drop 11 xs
      p = Packet { version = version
                 , typeId = typeid
                 , value = 0
                 , subpackets = subp
                 }
  in (p, rest)

parseOpPacket version typeid [] = error "what empty? "

parsePacket :: BitStream -> (Packet, BitStream)
parsePacket (a:b:c:d:e:f:xs) =
  let version = three a b c
      typeid = three d e f
      parser = if 4 == typeid then parseLiteralPacket else parseOpPacket
      (p, rest) = parser version typeid xs
  in (p, rest)

parsePacketsCond :: BitStream -> [Packet]
parsePacketsCond xs = if 7 > (length xs) then [] else parsePackets xs

parsePackets :: BitStream -> [Packet]
parsePackets [] = []
parsePackets xs =
    let
      (packet, rest) = parsePacket xs
    in packet : parsePacketsCond rest

packetVersionValue :: Packet -> Int
packetVersionValue p = version p + (packetsVersionValue $ subpackets p)

packetsVersionValue :: [Packet] -> Int
packetsVersionValue = foldl (\a b -> a + packetVersionValue b) 0

main :: IO ()
main = do
  line <- getLine
  let bitstream = fromhex line
      (packet, _) = parsePacket bitstream
      value = packetVersionValue packet
    in
    do
      putStrLn $ "packet version value: " ++ (show value)
