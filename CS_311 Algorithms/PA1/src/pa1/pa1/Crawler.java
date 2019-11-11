package pa1;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import api.Graph;
import api.Util;

/**
 * Implementation of a basic web crawler that creates a graph of some
 * portion of the world wide web.
 *
 * @author Shane Dooley
 */
public class Crawler
{
	private static int MAX_DEPTH = 0;
	private static int curDepth = 0;
	private static int MAX_PAGES = 0;
	private static int pageCounter = 0;
	private int linksLoaded = 1;
	private static Queue<String> Q = null; 
	private static NetworkGraph<String> g = null;

	
  /**
   * Constructs a Crawler that will start with the given seed url, including
   * only up to maxPages pages at distance up to maxDepth from the seed url.
   * @param seedUrl
   * @param maxDepth
   * @param maxPages
   */
  public Crawler(String seedUrl, int maxDepth, int maxPages)
  {
	  System.out.println("Start the crawling");
	  MAX_DEPTH = maxDepth;
	  MAX_PAGES = maxPages;
	  Q = new LinkedList<>();
	  Q.add(seedUrl); 
	  g = new NetworkGraph<>();
	  g.addVertex(seedUrl,seedUrl);
  }
  
  /**
   * Creates a web graph for the portion of the web obtained by a BFS of the 
   * web starting with the seed url for this object, subject to the restrictions
   * implied by maxDepth and maxPages.  
   * @return
   *   an instance of Graph representing this portion of the web
   */
  public Graph<String> crawl()
  {
	  String curUrl;
	  
	  while (!Q.isEmpty()){
		  curUrl = Q.remove();
		  curDepth = g.getLevel(curUrl);

		  try 
		  {
			linksLoaded++;
			Document doc = Jsoup.connect(curUrl).get();
			Elements links = doc.select("a[href]");
			if (linksLoaded % 50 == 0) {
				try { 
					System.out.println("Sleeping");
					Thread.sleep(3000); }
				catch (InterruptedException ignore){}
			}
			
			for (Element link : links) {
				String linkURL = link.attr("abs:href");
				if (Util.ignoreLink(curUrl, linkURL)) { continue;}
				if (!g.discovered(linkURL) && pageCounter+1 < MAX_PAGES && curDepth <= MAX_DEPTH ) { //Destination doesn't exist
					g.addVertex(linkURL,curUrl);
					pageCounter++;
					Q.add(linkURL);
				}
				if(g.discovered(linkURL)) {
					String s = curUrl.replace("https://en.wikipedia.org/wiki/", "");
					String d = linkURL.replace("https://en.wikipedia.org/wiki/", "");
					System.out.println("Linking "+s+" with "+d);
					g.addEdge(curUrl, linkURL);
				}
			}
		  } 
		  catch (org.jsoup.UnsupportedMimeTypeException | org.jsoup.HttpStatusException e) 
		  {
//			  e.printStackTrace();
		  } catch (IOException e) { //Everything else
//			e.printStackTrace();
		} 	 
	  }
    return g;
  }

}
