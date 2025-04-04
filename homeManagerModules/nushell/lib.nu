# get substring from start to the given index, returns empty string if negative
export def substring_to_idx [
  index: int # end index (included)
  --grapheme (-g) # use grapheme idx instead of byte offset
]: string -> string {
  let input = $in
  match $grapheme {
    _ if $index < 0 => ''
    true => ($input | str substring -g ..$index)
    false => ($input | str substring ..$index)
  }
}

# get substring from given index to the end, returns whole string if negative
export def substring_from_idx [
  index: int # start index (included)
  --grapheme (-g) # use grapheme idx instead of byte offset
]: string -> string {
  let input = $in
  match $grapheme {
    _ if $index < 0 => $input
    true => ($input | str substring -g $index..)
    false => ($input | str substring $index..)
  }
}
