import '../models/tree_node.dart';

class GrammarModel {
  List<String> nonTerminals = [];
  List<String> terminals = [];
  String startSymbol = '';
  Map<String, List<String>> rules = {};
  List<String> productions = [];

  void addProduction(String production) {
    productions.add(production);
    var parts = production.split("->");
    if (parts.length != 2) return;
    var lhs = parts[0].trim();
    var rhs = parts[1].split('|').map((e) => e.trim()).toList();
    rules.putIfAbsent(lhs, () => []).addAll(rhs);
  }

  void reset() {
    nonTerminals.clear();
    terminals.clear();
    startSymbol = '';
    rules.clear();
    productions.clear();
  }

  // Parse input string starting from symbol at pos index
  // Returns: ParseResult (node + next position) or null if fail
  ParseResult? parseInputString(String symbol, String input, int pos) {
    if (pos > input.length) return null;

    // If symbol is terminal: match exactly
    if (terminals.contains(symbol)) {
      if (pos < input.length && input[pos] == symbol) {
        return ParseResult(TreeNode(symbol), pos + 1);
      } else {
        return null;
      }
    }

    // If symbol is non-terminal
    if (!rules.containsKey(symbol)) {
      // No rules for this symbol, fail
      return null;
    }

    // Try each production option for this symbol
    for (var production in rules[symbol]!) {
      var currentPos = pos;
      var children = <TreeNode>[];

      var symbols = _splitSymbols(production);

      bool failed = false;

      for (var sym in symbols) {
        var res = parseInputString(sym, input, currentPos);
        if (res == null) {
          failed = true;
          break;
        } else {
          children.add(res.node);
          currentPos = res.nextPos;
        }
      }

      if (!failed) {
        // Successfully parsed this production
        return ParseResult(TreeNode(symbol, children), currentPos);
      }
    }

    // No production matched
    return null;
  }

  List<String> _splitSymbols(String s) {
    final result = <String>[];
    var buffer = '';
    for (var c in s.split('')) {
      buffer += c;
      if (nonTerminals.contains(buffer) || terminals.contains(buffer)) {
        result.add(buffer);
        buffer = '';
      }
    }
    if (buffer.isNotEmpty) result.add(buffer);
    return result;
  }
}

class ParseResult {
  final TreeNode node;
  final int nextPos;
  ParseResult(this.node, this.nextPos);
}
