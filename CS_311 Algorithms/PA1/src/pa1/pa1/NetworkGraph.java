package pa1;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import api.Graph;
import api.TaggedVertex;

/**
 * Abstract representation of a directed graph with generic vertex type.  
 * The array returned by vertexData() identifies each vertex with an
 * integer index.  The adjacency list for the vertex is
 * a list of these indices, as returned by getNeighbors(). Implementations
 * should ensure that there are no duplicate elements in the vertex data,
 * no self-edges, and no duplicate edges.
 * @param <E>
 * @param <E>
 */
public class NetworkGraph<E> implements Graph<String> {
	private ArrayList<String> vertNames = new ArrayList<String>();
	private HashMap<String, Integer> vertIndex = new HashMap<>(); 
	private ArrayList<TaggedVertex<String>> inEdgeCounts = new ArrayList<TaggedVertex<String>>();
	private HashMap<Integer, List<Integer>> inMap = new HashMap<>(); 
	private HashMap<Integer, List<Integer>> outMap = new HashMap<>(); 
	private HashMap<Integer,HashSet<Integer>> uniqueEdges = new HashMap<>(); 
	private HashMap<String,Integer> levels = new HashMap<>();
	
//	public NetworkGraph() { System.out.println("Constructing Network Graph"); }
	
	public boolean discovered(String url) { return vertIndex.containsKey(url); }
	
	private boolean isUniqueEdge(Integer s, Integer d) {
		return !(uniqueEdges.containsKey(s) && uniqueEdges.get(s).contains(d));
	}
	
	public Integer getLevel(String url) { return levels.get(url); }
	public Integer getURL(String url) {return vertIndex.get(url);}
	
	public void addVertex(String url, String parent) {
		if (!discovered(url)) {
			vertNames.add(url);
			vertIndex.put(url,vertNames.size()-1);
			TaggedVertex<String> curVert = new TaggedVertex<String>(url,0);
			inEdgeCounts.add(curVert);
			inMap.put(vertNames.size()-1, new ArrayList<Integer>());
			outMap.put(vertNames.size()-1, new ArrayList<Integer>());
			uniqueEdges.put(vertNames.size()-1, new HashSet<Integer>());
			if (!levels.containsKey(parent)) {
				System.out.println("Adding the root node: "+ url);
				levels.put(url, 0);
			} else {
				int myLevel = levels.get(parent);
				myLevel++;
				System.out.println("\t"+myLevel+" Adding new node: "+ url+" "+vertNames.size());
				levels.put(url, myLevel);
			}
		}
	}
	
	public boolean addEdge(String source,String destination) {
		assert discovered(source): "Haven't added the source vertex yet";
		if (source.equals(destination)) {return false;} //No self edges
		int sourceIndex = vertIndex.get(source);
		int destinationIndex = vertIndex.get(destination);
		if (!isUniqueEdge(sourceIndex,destinationIndex)) { return false; } //Edge already exists
		uniqueEdges.get(sourceIndex).add(destinationIndex);
		inMap.get(destinationIndex).add(sourceIndex);
		outMap.get(sourceIndex).add(destinationIndex);
		TaggedVertex<String> temp =  inEdgeCounts.get(destinationIndex);
		int curCount = temp.getTagValue();
		TaggedVertex<String> newEdge = new TaggedVertex<String>(temp.getVertexData(), curCount++);
		inEdgeCounts.set(destinationIndex, newEdge); 
		return true;
	}
	
	/**
	   * Returns an ArrayList of the actual objects constituting the vertices
	   * of this graph.
	   * @return
	   *   ArrayList of objects in the graph
	   */
	@Override
	public ArrayList<String> vertexData() {
		return vertNames;
	}

	/**
	   * Returns an ArrayList that is identical to that returned by vertexData(), except
	   * that each vertex is associated with its incoming edge count.
	   * @return
	   *   ArrayList of objects in the graph, each associated with its incoming edge count
	   */
	@Override
	public  ArrayList<TaggedVertex<String>> vertexDataWithIncomingCounts() {
		return inEdgeCounts;
	}

	  /**
	   * Returns a list of outgoing edges, that is, a list of indices for neighbors
	   * of the vertex with given index.
	   * This method may throw ArrayIndexOutOfBoundsException if the index 
	   * is invalid.
	   * @param index
	   *   index of the given vertex according to vertexData()
	   * @return
	   *   list of outgoing edges
	   */
	@Override
	public List<Integer> getNeighbors(int index) {
		// TODO Auto-generated method stub
		if (!outMap.containsKey(index)) {
			throw new ArrayIndexOutOfBoundsException(index);
		}
		return outMap.get(index);
	}
	
	/**
	   * Returns a list of incoming edges, that is, a list of indices for vertices 
	   * having the given vertex as a neighbor.
	   * This method may throw ArrayIndexOutOfBoundsException if the index 
	   * is invalid. 
	   * @param index
	   *   index of the given vertex according to vertexData()
	   * @return
	   *   list of incoming edges
	   */
	@Override
	public List<Integer> getIncoming(int index) {
		if (!inMap.containsKey(index)) {
			throw new ArrayIndexOutOfBoundsException(index);
		}
		return inMap.get(index);
	}
	
}
