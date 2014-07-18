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
	 * @param	selectors the typed parsed selectors
	 * @param	queryAll wether to get all matching descendant (true) or stop at the first match (false)
	 * @return	the list of matching nodes, might be empty
	 */
	static private function doQuerySelector(node : Node, selectors : Array<SelectorVO>, queryAll : Bool) : NodeList {

		// will hold all matching nodes
		var nodes : NodeList = new NodeList();

/*
		// first check the current node
		// FIXME var sm : SelectorMatcher = new SelectorMatcher();

		var matchedPseudoClass : MatchedPseudoClassesVO = getMatchedPseudoClassesVO(node);

		var matches : Bool = sm.match(node, selectors, matchedPseudoClass);
		// in cocktail-css-selector README, SelectorMatcher.match(node, selectors);
		// in cocktail-css-selector src, we have: .match(element:MatchableElement, selector:SelectorVO, matchedPseudoClasses:MatchedPseudoClassesVO)
		// in old cocktail: _ownerHTMLDocument.matchesSelector(node, selectors);

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
*/
		return nodes;
	}

	/**
	 * For a given node, return all of the
	 * pseudo classes that it currently matches
	 */
	static private function getMatchedPseudoClassesVO(node : Node) : MatchedPseudoClassesVO {
/*
		var hover : Bool = false;
		var focus : Bool = false;
		var active : Bool = false;
		var link : Bool = false;
		var enabled : Bool = false;
		var disabled : Bool = false;
		var checked : Bool = false;
        var fullscreen : Bool = false;
		
// FIXME		if (_hoveredElementRenderer != null) {

// FIXME			hover = _hoveredElementRenderer.domNode == node;
// FIXME		}
		//TODO 1 : shouldn't be null
		//check if node is the currently focused element
		if (activeElement != null) {

			focus = activeElement == node;
		}
		
		//check if the node is the currently active (moused down) one
// FIXME		if (_mousedDownedElementRenderer != null) {

// FIXME			active = _mousedDownedElementRenderer.domNode == node;
// FIXME		}
		
		//to match the :link pseudo class, the element must both be an anchor ("a") html element and also
		//have an "href" attribute
		if (node.tagName == DOMConstants.HTML_ANCHOR_TAG_NAME && 
			node.getAttribute(DOMConstants.HTML_HREF_ATTRIBUTE_NAME) != null) {

			link = true;
		}
		
		//enable/disable state only apply to form input element
		//
		//TODO 2 : check if it shouldn't apply to other elements
		if (node.tagName == DOMConstants.HTML_INPUT_TAG_NAME) {

			var inputNode : HTMLInputElement = cast(node);
			
			//check if a disabled attribute is present on the node
			//to determine wether the form control is enabled or disabled
			if (inputNode.disabled == false) {

				enabled = true;
				disabled = false;

			} else {

				disabled = true;
				enabled = false;
			}
			
			//check if the input element is checked
			if (inputNode.type == DOMConstants.INPUT_TYPE_CHECKBOX || 
				inputNode.type == DOMConstants.INPUT_TYPE_RADIO) {

				if (inputNode.checked == true) {

					checked = true;
				}
			}
		}

        //fullscreen state apply to all element while document is displayed fullscreen
// FIXME       if (fullscreenElement != null) {

// FIXME            fullscreen = true;
// FIXME        }

		var _matchedPseudoClasses : MatchedPseudoClassesVO;

		//store wether the store has an ID to know if it is
		//useful to match it against classes selector
		_matchedPseudoClasses.hasClasses = node.className != "";
		
		//store node classes
		if (_matchedPseudoClasses.hasClasses == true) {

			_matchedPseudoClasses.nodeClassList = node.classList;
		}
		
		//store wether the node has an ID to know
		//if it is useful to match it against ID selectors
		_matchedPseudoClasses.hasId = node.id != "";
		
		//store node id
		if (_matchedPseudoClasses.hasId == true) {

			_matchedPseudoClasses.nodeId = node.id;
		}
		
		//store the node type of the node
		_matchedPseudoClasses.nodeType = node.tagName;
		
		_matchedPseudoClasses.hover = hover;
		_matchedPseudoClasses.focus = focus;
		_matchedPseudoClasses.active = active;
		_matchedPseudoClasses.link = link;
		_matchedPseudoClasses.enabled = enabled;
		_matchedPseudoClasses.disabled = disabled;
		_matchedPseudoClasses.checked = checked;
		_matchedPseudoClasses.fullscreen = fullscreen;
		
		return _matchedPseudoClasses;
*/
	return null;
	}
}