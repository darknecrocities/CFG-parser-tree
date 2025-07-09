import '../models/tree_node.dart';

String renderTextTree(TreeNode node, [String indent = '', bool last = true]) {
  final buffer = StringBuffer();
  buffer.writeln('$indent${last ? "└─" : "├─"} ${node.label}');
  for (int i = 0; i < node.children.length; i++) {
    final child = node.children[i];
    final isLast = i == node.children.length - 1;
    buffer.write(
      renderTextTree(child, indent + (last ? '   ' : '│  '), isLast),
    );
  }
  return buffer.toString();
}
