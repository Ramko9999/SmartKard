import 'dart:collection';

class Trie{
  
  _Node root;

  Trie(){
    root = _Node('');
  }

  void fillTrie(words){
    for(int i = 0; i < words.length; i++){
      String word = words[i];
      _Node current = this.root;
      for(int  j = 0; j < word.length; j++){
        String char = word[j];
        if(current.chars[char] == null){
          current.chars[char] = _Node(char);
          if(j == word.length - 1){
            current.chars[char] = _Node(char, isEnd: true);
          }
        }
        current = current.chars[char];
      }
    }
  }

  List<String> getResults(query){
    
    //run down the Trie
    _Node current = this.root;
    for(int i = 0; i < query.length; i++){
        _Node temp = current.chars[query[i]];
        if(temp == null){
          break;
        }
        current = temp;
    }

    List<String> results = [];
    Queue<MapEntry<_Node, List<String>>> charStruct = Queue();
    charStruct.addLast(MapEntry(current, []));
    while(charStruct.isNotEmpty){
      MapEntry<_Node, List<String>> node = charStruct.removeLast();
      if(node.key.isEnd){
        //add the word
        results.add(node.value.join(''));
      }

      //iterate over remaining possible _Nodes that are not null and add to stack
      node.key.chars.forEach((k,v){
        if(v != null){
          charStruct.add(MapEntry(v, node.value + [v.letter]));
        }
      });
    }
  
  return results;
  }
}

class _Node{
  Map<String, _Node> chars;
  bool isEnd = false;
  String letter;

  //initalize a trie node
  _Node(letter, {bool isEnd}){

    this.letter  = letter;
    if(isEnd != null){
      this.isEnd = isEnd;
    }

    for(int i = 0; i < 10; i++){
      this.chars[i.toString()] = null;
    }
    for(int i = 65; i < 91; i++){
      String char = String.fromCharCode(i);
      this.chars[char] = null;
      this.chars[char.toUpperCase()] = null;
    }

    this.chars['@'] = null;
    this.chars['.'] = null;
  }
}
