import 'package:flutter/material.dart';

import '../models/grammar_model.dart';
import '../models/tree_node.dart';
import '../widgets/tree_view.dart';

class CFGHomePage extends StatefulWidget {
  const CFGHomePage({super.key});

  @override
  State<CFGHomePage> createState() => _CFGHomePageState();
}

class _CFGHomePageState extends State<CFGHomePage> {
  final grammar = GrammarModel();
  final TextEditingController productionController = TextEditingController();
  final TextEditingController inputStringController = TextEditingController();
  TreeNode? root;
  String? errorMessage;

  void addProduction() {
    grammar.addProduction(productionController.text);
    productionController.clear();
    setState(() {});
  }

  void resetGrammar() {
    grammar.reset();
    productionController.clear();
    inputStringController.clear();
    root = null;
    errorMessage = null;
    setState(() {});
  }

  void parseInput() {
    if (grammar.startSymbol.isEmpty) return;
    errorMessage = null;

    final input = inputStringController.text.replaceAll(' ', '');
    if (input.isEmpty) {
      errorMessage = "Input string is empty";
      root = null;
      setState(() {});
      return;
    }

    final result = grammar.parseInputString(grammar.startSymbol, input, 0);
    if (result != null && result.nextPos == input.length) {
      root = result.node;
    } else {
      root = null;
      errorMessage = "Input string cannot be derived by grammar.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CFG Parser Tree by Rhonzkie")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Non-Terminals (e.g., S,A,B)",
              ),
              onChanged: (val) => grammar.nonTerminals = val
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Terminals (e.g., a,b)",
              ),
              onChanged: (val) => grammar.terminals = val
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Start Symbol"),
              onChanged: (val) => grammar.startSymbol = val.trim(),
            ),
            const Divider(height: 30),
            const Text(
              "Add Production Rule (e.g., S -> aA | b)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(child: TextField(controller: productionController)),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addProduction,
                  child: const Text("Add"),
                ),
              ],
            ),
            ...grammar.productions.map((e) => ListTile(title: Text(e))),
            const Divider(height: 30),
            TextField(
              controller: inputStringController,
              decoration: const InputDecoration(
                labelText: "Input String (e.g., ab)",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: parseInput,
                  child: const Text("Parse"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetGrammar,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (root != null) ...[
              const Text(
                "Derivation Tree (Text View):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(renderTextTree(root!)),
            ],
          ],
        ),
      ),
    );
  }
}
