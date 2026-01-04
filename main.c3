import bst;
import std::io;

// INT BST
fn void bst_int_demo() {
    bst::BSTNode{int}* root = null;

    root = bst::insert{int}(root, 10);
    root = bst::insert{int}(root, 5);
    root = bst::insert{int}(root, 15);
    root = bst::insert{int}(root, 10); // Attempt to insert a duplicate
    root = bst::delete{int}(root, 5);
    io::printn("Inorder Traversal of BST:");
    bst::inorderTraversal{int}(root); 
    bst::BSTNode{int}* foundNode = bst::search{int}(root, 15);
    if (foundNode) { 
        io::printn("Found node with value: "); 
        io::printn(foundNode.value); 
    } else {
        io::printn("Node not found.");
    }

    root = bst::delete{int}(root, 10);
    free(root);
}

// DOUBLE BST
fn void bst_double_demo() {
    bst::BSTNode{double}* root = null;

    root = bst::insert{double}(root, 10.5);
    root = bst::insert{double}(root, 5.2);
    root = bst::insert{double}(root, 15.8);
    root = bst::delete{double}(root, 5.2);
    io::printn("Inorder Traversal of Double BST:");
    bst::inorderTraversal{double}(root); 
    bst::BSTNode{double}* foundNode = bst::search{double}(root, 15.8);
    if (foundNode) { 
        io::printn("Found node with value: "); 
        io::printn(foundNode.value); 
    } else {
        io::printn("Node not found.");
    }

    root = bst::delete{double}(root, 10.5);
    free(root);
}

fn void main() {
    bst_int_demo();
    bst_double_demo();
}
