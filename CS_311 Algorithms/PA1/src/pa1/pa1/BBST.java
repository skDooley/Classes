package pa1;

import java.util.HashMap;


 
public class BBST // Balanced Binary Search Tree
{
	class Node
	{
	    Node left, right, parent;
	    int value;
	    int height;
	    String url;
	 
	    public Node()
	    {
	    	parent = null;
	        left = null;
	        right = null;
	        value = 0;
	        height = 0;
	    }
	 
	    public Node(String url,int weight)
	    {
	    	parent = null;
	        left = null;
	        right = null;
	        value = weight;
	        height = 0;
	        this.url=url;
	    }
	}
	
    private Node root;
    private Node maxNode;
    private Node minNode;
    private HashMap<String,Node> allNodes = new HashMap<>();

    public void insert(String url, int weight)
    { 
    	if (allNodes.containsKey(url)){
    		update(allNodes.get(url),weight);
    	} else {
    		root = insert(url, weight, root, root);
    	}
    }
    public void print() {
    	print(root);
    }
    private void print(Node curNode) {
    	String lc = (curNode.left == null ? "" : curNode.left.url);
    	int lcv = (curNode.left == null ? 0 : curNode.left.value);
    	String rc = (curNode.right == null ? "" : curNode.right.url);
    	int rcv = (curNode.right == null ? 0 : curNode.right.value);
    	String p = (curNode.parent == null ? "" : curNode.parent.url);
		System.out.println(curNode.url+"("+curNode.value+")" + " L="+lc+"("+lcv+")"+" R="+rc+"("+rcv+")"+"   "+p);
		if (curNode.left!=null) {
			print(curNode.left);
		}
		if (curNode.right!=null) {
			print(curNode.right);
		}
	}
	private int height(Node curNode) { return curNode == null ? -1 : curNode.height; }
    private int max(int leftHeight, int rightHeight) { return leftHeight > rightHeight ? leftHeight : rightHeight; }
    
    private void update(Node curNode, int weight) {
//    	//Check up the tree or down the tree?
//    	boolean checkDown = (curNode.value>=root.value);
    	curNode.value = ((curNode.value/weight)+1)*weight;
    	
    	update(curNode);
//    	if (checkDown) {
//    		updateDown(curNode);
//    	} else {
//    		curNode = updateUp(curNode); 
//    		if (curNode == root) { //If things update so much this node belongs on other side of tree
//    			System.out.println("This is against BigO so I should figure out how to remove nodes");
//    			updateDown(curNode);
//    		}
//    	}
    }

    private Node update(Node curNode) {

    	
		// Go as high in the tree as possible
    	if (curNode.parent != null && curNode.parent.value < curNode.value) {
//    		System.out.println("\nCurNodeParent: "+curNode.url);
    		curNode = switchNodes(curNode,curNode.parent);
//    		System.out.println("CurNode: "+curNode.url+"\n");
    		return update(curNode);
    		
    	}
    	if (curNode.right != null && curNode.right.value < curNode.value) {
//    		System.out.println("\nCurNodeBefore: "+curNode.url+" "+curNode.value);
//    		System.out.println("SwitchNBefore: "+curNode.right.url+" "+curNode.right.value);
    		switchNodes(curNode,curNode.right);
//    		System.out.println("CurNodeAfter: "+curNode.url+" "+curNode.value);
//    		System.out.println("SwitchNAfter: "+curNode.right.url+" "+curNode.right.value);
    		
    		return update(curNode);
    	}
    	return curNode;
    	
//    	if (curNode.parent != null) {
//		System.out.println("Starting with parent: "+curNode.parent.url+"<-"+curNode.url);
//	}
//    	while (){
//    		
//    		if (curNode.parent.left == curNode) {
//    			System.out.println("L "+curNode.url+" "+curNode.value);
//    			//Switch parent with current node
//    			curNode = update(switchNodes(curNode,curNode.parent));
//    			
////    			Node temp = curNode;
////    			System.out.println("L "+temp.url+" "+temp.value);
////    			#rotateRight(curNode.parent);
////    			curNode = temp;
//    			
//    		} else {
//    			System.out.println((curNode.parent.right == curNode)+" "+ (curNode.parent.left == curNode));
//    			Node temp = curNode;
//    			System.out.println("R "+temp.url+" "+temp.value+" "+ temp.parent.url);
//    			rotateLeft(curNode.parent);
//    			curNode = temp;
//    			System.out.println("R "+curNode.url+" "+curNode.value+ curNode.parent.url);
//    		}
//    	}
//    	System.out.println("Now at: "+curNode.parent.url);
//    	
    	// Then go down the tree until find the spot
    	// Go right
//    	while (curNode.right != null & curNode.right.value > curNode.value) {
//    		curNode = rotateLeft(curNode);
//    	}
    	// Go left
    	
    	
//    	return curNode;
		
	}
	private Node switchNodes(Node curNode, Node switchNode) {
		String switchURL = switchNode.url;
		Integer switchWeight = switchNode.value;
		switchNode.url = curNode.url;
		switchNode.value = curNode.value;
		curNode.url = switchURL;
		curNode.value = switchWeight;
		return switchNode;
	}
//		if (parent.left == curNode) {
//			System.out.println("IsLeft"+(parent.parent == curNode));
//			String parentURL = parent.url;
//			Integer parentWeight = parent.value;
//			parent.url = curNode.url;
//			parent.value = curNode.value;
//			curNode.url = parentURL;
//			curNode.value = parentWeight;
//		} else { // parent
//			System.out.println("IsParent"+(parent.parent == curNode));
//		}


//	private Node updateUp(Node curNode) {
//    	Node dest = curNode.parent;
//		while (curNode.parent != root & curNode.parent.value < curNode.value) {
//			
//		}
//		return null;
//	}
//	private Node updateDown(Node curNode) {
//		if (curNode.value > curNode.right.value) { //Go as far right as I can
//			curNode = updateDown(rotateLeft(curNode));
//		} 
//		if (curNode.value < curNode.left.value) { //Go as far left as I can
//			curNode = updateDown(rotateRight(curNode));
//		}
//		return curNode;
//		
//	}
	private Node insert(String url, int weight, Node curNode, Node parent)
    {
        if (curNode == null) { //Root is null or reached a leaf
            curNode = new Node(url,weight);
            if (parent == null) {
            	parent=curNode;}
            allNodes.put(url, curNode);
//            System.out.println("Adding: "+curNode.url+"<-is child of:"+parent.url);
            if (curNode != parent && curNode.parent == null) { curNode.parent = parent; }
            
        }
        else if (weight <= curNode.value)
        {
            curNode.left = insert(url, weight, curNode.left, curNode);
            
            if (height(curNode.left) - height(curNode.right) == 2)
                if (weight <= curNode.left.value)
                    curNode = rotateRight(curNode);
                else
                    curNode = doubleWithLeftChild(curNode);
        } else if (weight >= curNode.value)
        {
            curNode.right = insert(url, weight, curNode.right, curNode);
            
            if (height(curNode.right) - height(curNode.left) == 2)
                if (weight >= curNode.right.value)
                    curNode = rotateLeft(curNode);
                else
                    curNode = doubleWithRightChild(curNode);
        } else {
        	System.out.println(curNode.url+" "+"Equal?");
        }
        	
        curNode.height = max(height(curNode.left), height(curNode.right)) + 1;
        return curNode;
    }
 
    private Node rotateRight(Node node1)
    {
        Node node2 = node1.left;
//        System.out.println("RoRight:"+node1.url + "<->"+node2.url);
        //Parent setting
        node2.parent = node1.parent;
        node1.parent = node2;
//        if (node2.left != null)  { node2.left.parent = node1; }
        if (node2.right != null) { node2.right.parent = node1; }
//        if (node1.right != null) { node1.right.parent = node2; }
        
        //children setting
        node1.left = node2.right;
        node2.right = node1;
        //height setting
        node1.height = max(height(node1.left), height(node1.right)) + 1;
        node2.height = max(height(node2.left), node1.height) + 1;
        return node2;
    }
 
    private Node rotateLeft(Node node1)
    {
        Node node2 = node1.right;
        System.out.println("RoLeft: "+node1.url + "<->"+node2.url);
        
      //Parent setting
        node2.parent = node1.parent;
        node1.parent = node2;
        if (node2.left != null)  { node2.left.parent  = node1; }
        
        //children setting
        node1.right = node2.left;
        node2.left = node1;
        //height setting
        node1.height = max(height(node1.left), height(node1.right)) + 1;
        node2.height = max(height(node2.right), node1.height) + 1;
        return node2;
    }
 
    private Node doubleWithLeftChild(Node n)
    {
    	System.out.println("DoubleL");
        n.left = rotateLeft(n.left);
        return rotateRight(n);
    }
 
    private Node doubleWithRightChild(Node n)
    {
    	System.out.println("DoubleR");
        n.right = rotateRight(n.right);
        return rotateLeft(n);
    }
 
    public int countNodes()
    {
        return countNodes(root);
    }
 
    private int countNodes(Node r)
    {
        if (r == null)
            return 0;
        else
        {
            int l = 1;
            l += countNodes(r.left);
            l += countNodes(r.right);
            return l;
        }
    }
 
    public boolean search(int val)
    {
        return search(root, val);
    }
 
    private boolean search(Node r, int val)
    {
        boolean found = false;
        while ((r != null) && !found)
        {
            int rval = r.value;
            if (val < rval)
                r = r.left;
            else if (val > rval)
                r = r.right;
            else
            {
                found = true;
                break;
            }
            found = search(r, val);
        }
        return found;
    }
 
    public void inorder()
    {
        inorder(root);
    }
 
    private void inorder(Node r)
    {
        if (r != null)
        {
            inorder(r.left);
            System.out.print(r.value + " ");
            inorder(r.right);
        }
    }
 
    public void preorder()
    {
 
        preorder(root);
    }
 
    private void preorder(Node r)
    {
        if (r != null)
        {
            System.out.print(r.value + " ");
            preorder(r.left);
            preorder(r.right);
        }
    }
 
    public void postorder()
    {
        postorder(root);
    }
 
    private void postorder(Node r)
    {
        if (r != null)
        {
            postorder(r.left);
            postorder(r.right);
            System.out.print(r.value + " ");
        }
    }
}

//public class OrderedLinkedList { 
//    Node root; 
//    Node tail;
//    int maxVal=0;
//    int midVal=0;
//    int minVal=0;
//    HashMap<String,Node> allNodes = new HashMap<>();
//    HashMap<Integer,Node>
//  
//    /* Doubly Linked list Node*/
//    class Node { 
//        int weight; 
//        Node prev; 
//        Node next; 
//        int index = -1;
//        String url;
//  
//        // Constructor to create a new node 
//        // next and prev is by default initialized as null 
//        Node(String url,int weight) { 
//        	this.url = url;
//        	this.weight = weight; 
//        } 
//    } 
//    
//    public void add(String url,int weight) {
//    	boolean needsUpdate = true;
//    	Node curNode;
//
//		//If the url already exists
//    	if (allNodes.containsKey(url)) {
//			// Retrieve and update weight
//    		curNode = allNodes.get(url);
//    		curNode.weight = ((curNode.weight/weight)+1)/weight;
//    		needsUpdate = (curNode.prev != null & curNode.weight > curNode.prev.weight);
//    	} else {
//    		curNode = new Node(url,weight);
//    		allNodes.put(url, curNode);
//    	}
//    	if (needsUpdate) {
//    		updateList(curNode,weight);
//    	}
//
//    }
//    
//    private void updateList(Node curNode, int weight) {
//		// Base Case: root is null
//    	if (root == null) {
//    		root = curNode;
//    		tail = curNode;
//    		midVal = weight;
//    	}
//    	else {
//    		if (weight > root.weight) { // Prepend
//    			root.prev = curNode;
//    			curNode.next = root;
//    			root = curNode;
//    		} else if (weight < tail.weight) { // Append
//    			tail.next = curNode;
//    			curNode.prev = tail;
//    			tail = curNode;
//    		} else { // Somewhere in the middle
//    			if (curNode.prev == null) { //This is a new node being added to the tree
//    				
//    			}
//    			else if (curNode.next == null) { //This is the tail node
//    				
//    			}
//    			else{ //Middling node
//    				
//    			}
//    			
//    		}
//    	}
//	}
//
//	public void insertAfter(Node prev_Node, String url,int weight) 
//	{ 
//
//	    Node new_node = new Node(url,weight); 
//	  
//	    /* 4. Make next of new node as next of prev_node */
//	    new_node.next = prev_Node.next; 
//	  
//	    /* 5. Make the next of prev_node as new_node */
//	    prev_Node.next = new_node; 
//	  
//	    /* 6. Make prev_node as previous of new_node */
//	    new_node.prev = prev_Node; 
//	  
//	    /* 7. Change previous of new_node's next node */
//	    if (new_node.next != null) { new_node.next.prev = new_node; }
//	} 
//} 