/**
 * Cocktail DOM Implementation
 * @see https://github.com/haxecocktail/cocktail-dom
 * 
 * Cocktail, HTML rendering engine
 * @see http://haxe.org/com/libs/cocktail
 *
 * Copyright (c) Silex Labs 2013 - 2014
 * Cocktail is available under the MIT license
 * @see http://www.silexlabs.org/labs/cocktail-licensing/
 */
package cocktail.dom;

import cocktail.selector.SelectorsParser;
import cocktail.selector.SelectorMatcher;
import cocktail.selector.SelectorData;

/**
 * @see http://www.w3.org/TR/dom/#scope-match-a-selectors-string
 */
@:access(cocktail.dom)
class QuerySelectorTools {

	static public function querySelector(context : Node, selectors : String) : Null<Element> {

		var s : Array<SelectorVO> = SelectorsParser.parse(selectors);

		// If s is failure, throw a JavaScript TypeError.
		// FIXME
		
		var nodes : NodeList = doQuerySelector(context, s, false);

		if (nodes.length == 0) {

			return null;
		}
		return Std.instance(nodes[0], Element);
	}

    static public function querySelectorAll(context : Node, selectors : String) : NodeList {

		var s : Array<SelectorVO> = SelectorsParser.parse(selectors);

		// If s is failure, throw a JavaScript TypeError.
		// FIXME
		
		return doQuerySelector(context, s, true);
    }


	/**
	 * Do get the node matching the selectors, starting from node and checking
	 * all the descendants recursively
	 * 
	 * @param	node the current node
	 * @param	selectors the selectors string
	 * @param	queryAll wether to get all matching descendant (true) or stop at the first match (false)
	 * @return	the list of matching nodes, might be empty
	 */
	static private function doQuerySelector(node : Node, selectors : Array<SelectorVO>, queryAll : Bool) : NodeList {

		// will hold all matching nodes
		var nodes : NodeList = new NodeList();

		// first check the current node
		var matches : Bool = false;

		for (s in selectors) {

			matches = matches || SelectorMatcher.match(Std.instance(node, Element), s);
		}

		if (matches == true) {

			nodes.push(node);

			// if false, stop on first matching node
			if (queryAll == false) {

				return nodes;
			}
		}

		// check all descendant
		var length : Int = node.childNodes.length;

		for (i in 0...length) {

			// only applies to element nodes
			if (node.childNodes[i].nodeType == Node.ELEMENT_NODE) {

				var matchingNodes : NodeList = doQuerySelector(node.childNodes[i], selectors, queryAll);

				// if queryAll false, stop on first match
				if (queryAll == false && matchingNodes.length > 0) {

					return matchingNodes;
				}
				
				// else add all matching nodes
				var matchingNodesLength : Int = matchingNodes.length;

				for (j in 0...matchingNodesLength) {

					nodes.push(matchingNodes[j]);
				}
			}
		}

		return nodes;
	}
}