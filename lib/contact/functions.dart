import 'dart:collection';

class Trie{
  
  _Node root;
  List<String> names;
  Trie(){
    root = _Node('');
  }

  void fillTrie(words){
    this.names = words;
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

    query = query.toString().trim();
    //run down the Trie
    _Node current = this.root;
    for(int i = 0; i < query.length; i++){
        current = current.chars[query[i]];
        if(current == null){
          return [];
        }
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
  
  for(int i = 0; i < results.length; i++){
    results[i] = query + results[i];
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
    this.chars = {};

    for(int i = 65; i < 91; i++){
      String char = String.fromCharCode(i);
      this.chars[char] = null;
      this.chars[char.toUpperCase()] = null;
    }



    this.chars[' '] = null;
  }
}
