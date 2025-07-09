class TreeNode {
  final String label;
  final List<TreeNode> children;

  TreeNode(this.label, [List<TreeNode>? children])
    : children = children ?? <TreeNode>[];
}
