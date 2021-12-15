#!/usr/bin/env ruby

start = nil
$rules = {}
STDIN.read.split("\n").select {|line| 0 < line.strip.size }.each do |line|
  if start == nil
    start = line
  else
    a, _, b = line.strip.split(" ")
    $rules[a] = b
  end
end

MAX = if 0 == ARGV.length
        10
      else
        Integer(ARGV[-1])
      end

$memo = {}
def score(a, b, depth)
  memo_key = [a, b, depth]
  if not $memo.has_key? memo_key
    if depth >= MAX
      return {}
    end
    ret = Hash.new
    ab = a + b
    if $rules.has_key? ab
      c = $rules[ab]
      ret[c] = 1
      d = score(a, c, 1 + depth).each { |k,v|
        ret[k] = ret.fetch(k, 0) + v
      }
      score(c, b, 1 + depth).each { |k,v|
        ret[k] = ret.fetch(k, 0) + v
      }
    end
    $memo[memo_key] = ret
  end
  return $memo[memo_key]
end

N = start.length

scores = {}

start.split('').each { |x| scores[x] = 1 }

(1..N-1).each do |i|
  a = start[i-1]
  b = start[i]
  score(a, b, 0).each { |k,v|
    scores[k] = scores.fetch(k, 0) + v
  }
end

puts(scores.values.max - scores.values.min)
