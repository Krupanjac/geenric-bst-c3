module bst @generic(Type);
import std::io;



struct BSTNode {
    Type value;
    BSTNode* left;
    BSTNode* right;
    BSTNode *parent;

}


fn BSTNode* init(Type value, BSTNode* parent) {
    BSTNode* node = mem::new (BSTNode);
    node.value = value;
    node.left = null;
    node.right = null;
    node.parent = parent;
    return node;
}


//Insert begins as unsucessful search so we first search for the value 

fn BSTNode* search(BSTNode* root, Type value) {
    BSTNode* current = root;
    while (current) {
        if (value == current.value) return current;
        
        if (value < current.value){
        current = current.left;
        }
        else {
        current = current.right;
        }
    }
    return null;
}


fn BSTNode* insert(BSTNode* root, Type value) {
    if (!root) {
        return init(value, null);
    }
  if (search(root, value)){
        io::printn("Value already exists in the BST.");
        return root;
    }

    BSTNode* current = root;
    BSTNode* parent = null;
    while (current) {
        parent = current;
        if (value < current.value) {
            current = current.left;
        } else {
            current = current.right;
        }
    }
    BSTNode* newNode = init(value, parent);
    if (value < parent.value) {
        parent.left = newNode;
    } else {
        parent.right = newNode;
    }
    return root;
}


