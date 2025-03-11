   Class EmojiCodec (A: Type) := {
     encode : A -> list Emoji;
     decode : list Emoji -> option A;
     encode_decode_law : forall x, decode (encode x) = Some x;
     decode_encode_law : forall es x, decode es = Some x -> encode x = es
   }