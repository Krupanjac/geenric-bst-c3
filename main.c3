import bst;
import std::io;


fn void inorderTraversal(bst::BSTNode{int}* node) {
    if (node == null) {
        return;
    }
    inorderTraversal(node.left);
    io::printn(node.value);
    inorderTraversal(node.right);
}

fn void main() {
    bst::BSTNode{int}* root = null;

    root = bst::insert{int}(root, 10);
    
    root = bst::insert{int}(root, 5);
    root = bst::insert{int}(root, 15);
    root = bst::insert{int}(root, 10); // Attempt to insert a duplicate
    
    io::printn("Inorder Traversal of BST:");
    inorderTraversal(root);
bst::BSTNode{int}* foundNode = bst::search{int}(root, 15);
    if (foundNode) { 
        io::printn("Found node with value: "); 
        io::printn(foundNode.value); } 
    else {
        io::printn("Node not found.");
    } 
}
