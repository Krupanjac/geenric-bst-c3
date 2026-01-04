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
    while(current) {
        switch {
            case value == current.value: return current;
            case value < current.value: current = current.left;
            default: current = current.right;
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


fn BSTNode* successor(BSTNode* node) {
    if (!node) {
        return null;
    }
    // If right subtree exists, go to leftmost node in right subtree
    if (node.right) {
        BSTNode* current = node.right;
        while (current.left) {
            current = current.left;
        }
        return current;
    }
    // Otherwise, go up until we find a node that is left child of its parent
    BSTNode* current = node;
    BSTNode* parent = node.parent;
    while (parent && current == parent.right) {
        current = parent;
        parent = parent.parent;
    }
    return parent;
}


fn BSTNode* delete(BSTNode* node, Type value) {
    if (!node) return null;

    BSTNode* target = search(node, value);
    if (!target) {
        io::printn("Value not found in the BST.");
        return node;
    }

    // Case 1: leaf
    if (!target.left && !target.right) {
        if (target.parent) {
            switch{
                case (target == target.parent.left):
                target.parent.left = null;
            default: 
                target.parent.right = null;
                }
        } else {
            node = null;
        }
        free(target);
    }

    // Case 2: one child
    else if (!target.left || !target.right) {
        BSTNode* child = target.left ? target.left : target.right;

        if (target.parent) {
            switch{
                case (target == target.parent.left):
                target.parent.left = child;
                default:
                target.parent.right = child;
            }
        } else {
            node = child;
        }

        child.parent = target.parent;
        free(target);
    }

    // Case 3: two children
    else {
        BSTNode* succ = successor(target);
        target.value = succ.value;

        BSTNode* child = succ.right;
        switch{
            case (succ.parent.left == succ):
            succ.parent.left = child;
            default:
            succ.parent.right = child;
        }
        if (child) child.parent = succ.parent;


        free(succ);
    }

    return node;
}

fn BSTNode* freeBST(BSTNode* node) {
    if (!node) {
        return null;
    }
    while(node){
        node = delete(node, node.value);
    }
    return node;
}

fn BSTNode* minValueNode(BSTNode* node) {
    BSTNode* current = node;
    while (current && current.left) {
        current = current.left;
    }
    return current;
}

fn BSTNode* maxValueNode(BSTNode* node) {
    BSTNode* current = node;
    while (current && current.right) {
        current = current.right;
    }
    return current;
}

fn void inorderTraversal(BSTNode* node) {
    if (node == null) {
        return;
    }
    inorderTraversal(node.left);
    io::printn(node.value);
    inorderTraversal(node.right);
}
