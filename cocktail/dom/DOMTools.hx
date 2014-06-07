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

/**
 * @see http://www.w3.org/TR/dom/#mutation-algorithms
 */
class DOMTools {

	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-node-clone
	 */
	static public function clone(node : Node, ? document : Null<Document>, ? cloneChildren : Bool = false) : Node {

		if (document == null) {

			document = node.ownerDocument;
		}
		var copy : Node = doCloneNode();

		if (copy.nodeType == Node.DOCUMENT_NODE) {

			adopt(copy, copy);
			document = copy;
		
		} else {

			adopt(copy, document);
		}
		switch (node.nodeType) {

			case Node.DOCUMENT_NODE:
				// Its encoding, content type, URL, its mode (quirks mode, limited quirks mode, 
				// or no-quirks mode), and its type (XML document or HTML document).
            #if strict
                throw "Not implemented!";
            #end

			case Node.DOCUMENT_TYPE_NODE:
				// Its name, public ID, and system ID.
            #if strict
                throw "Not implemented!";
            #end

			case ELEMENT_NODE:
				// Its namespace, namespace prefix, local name, and its attribute list.
            #if strict
                throw "Not implemented!";
            #end

			case TEXT_NODE, COMMENT_NODE:
				// Its data
            #if strict
                throw "Not implemented!";
            #end

			case PROCESSING_INSTRUCTION_NODE:
				// Its target and data
            #if strict
                throw "Not implemented!";
            #end

			default: // -
		}
		// Run any cloning steps defined for node in other applicable specifications and pass 
		// copy, node, document and the clone children flag if set, as parameters.

        if (cloneChildren) {

            for (i in 0...node.childNodes.length) {

                copy.appendChild(clone(node.childNodes[i], document, cloneChildren));
            }
        }
        return copy;
	}

	/**
	 * @see http://www.w3.org/TR/dom/#concept-node-replace
	 */
	static public function replace(child : Node, node : Node, parent : Node) : Node {

		// If parent is not a Document, DocumentFragment, or Element node, throw a "HierarchyRequestError".
		if (parent.nodeType != Node.DOCUMENT_NODE &&
			parent.nodeType != Node.DOCUMENT_FRAGMENT_NODE &&
			parent.nodeType != Node.ELEMENT_NODE) {
	
			throw "HierarchyRequestError";
		}

		// TODO If node is a host-including inclusive ancestor of parent, throw a "HierarchyRequestError".
		// @see http://www.w3.org/TR/dom/#concept-tree-host-including-inclusive-ancestor

		// If child's parent is not parent, throw a "NotFoundError" exception.
		if (child.parentNode != parent) {

			throw "NotFoundError";
		}

		// If node is not a DocumentFragment, DocumentType, Element, Text, ProcessingInstruction, or Comment node, 
		// throw a "HierarchyRequestError".
		if (node.nodeType != Node.DOCUMENT_FRAGMENT_NODE &&
			node.nodeType != Node.DOCUMENT_TYPE_NODE &&
			node.nodeType != Node.ELEMENT_NODE &&
			node.nodeType != Node.TEXT_NODE &&
			node.nodeType != Node.PROCESSING_INSTRUCTION_NODE &&
			node.nodeType != Node.COMMENT_NODE) {

			throw "HierarchyRequestError";
		}

		// If either node is a Text node and parent is a document, or node is a doctype and parent is not a document, 
		// throw a "HierarchyRequestError".
		if (node.nodeType == Node.TEXT_NODE && parent.nodeType == Node.DOCUMENT_NODE || 
			node.nodeType == Node.DOCUMENT_TYPE_NODE && parent.nodeType != Node.DOCUMENT_NODE) {

			throw "HierarchyRequestError";
		}

		// If parent is a document, and any of the statements below, switched on node, are true, 
		// throw a "HierarchyRequestError".
		if (parent.nodeType != Node.DOCUMENT_NODE) {

			if (node.nodeType == Node.DOCUMENT_FRAGMENT_NODE) {

				// If node has more than one element child or has a Text node child.
				if (node.childNodes.length > 1 || 
					node.childNodes.length == 1 && node.childNodes[0].nodeType == Node.TEXT_NODE) {

					throw "HierarchyRequestError";
				}
				// Otherwise, if node has one element child and either parent has an element child 
				// that is not child or a doctype is following child.
				if (node.childNodes.length == 1) {

					if (parent.childNodes.length == 1 && parent.childNodes[0] != child ||
						child.nextSibling != null && child.nextSibling.nodeType == Node.DOCUMENT_TYPE_NODE) {
						
						throw "HierarchyRequestError";
					}
				}
			}
			if (node.nodeType == Node.ELEMENT_NODE) {
				// parent has an element child that is not child or a doctype is following child.
				if (parent.childNodes.length == 1 && parent.childNodes[0] != child ||
					child.nextSibling != null && child.nextSibling.nodeType == Node.DOCUMENT_TYPE_NODE){

					throw "HierarchyRequestError";
				}
			}
			if (node.nodeType == Node.DOCUMENT_TYPE_NODE) {
				// parent has a doctype child that is not child, or an element is preceding child.
				if (parent.childNodes.length == 1 && parent.childNodes[0] != child && 
					parent.childNodes[0].nodeType == Node.DOCUMENT_TYPE_NODE ||
					child.previousSibling != null && child.previousSibling.nodeType == Node.ELEMENT_NODE) {

					throw "HierarchyRequestError";
				}
			}
		}
		// Let reference child be child's next sibling.
		var referenceChild : Node = child.nextSibling;

		// If reference child is node, set it to node's next sibling.
		if (referenceChild == node) {

			referenceChild = node.nextSibling;
		}

		// Adopt node into parent's node document.
		adopt(node, parent.ownerDocument);

		// Remove child from its parent with the suppress observers flag set.
		remove(child, child.parentNode);

		// Insert node into parent before reference child with the suppress observers flag set.
		insert(node, parent, referenceChild);

		// Let nodes be node's children if node is a DocumentFragment node, and a list containing solely node otherwise.
		var nodes = node.nodeType == Node.DOCUMENT_FRAGMENT_NODE ? node.childNodes : [node];

		// TODO Queue a mutation record of "childList" for target parent with addedNodes nodes, 
		// removedNodes a list solely containing child, nextSibling reference child, and previousSibling 
		// child's previous sibling.


		// TODO Run node is removed for child, and then for each node in nodes, in tree order, run node is inserted.


		// Return child.
		return child;
	}


	/**
	 * @see http://www.w3.org/TR/dom/#concept-node-replace-all
	 */
	static public function replaceAll(node : Node, parent : Node) : Void {

		/*
		If node is not null, adopt node into parent's node document.
		*/
		if (node != null) {

			adopt( node, parent.ownerDocument );
		}

		/*
		Let removedNodes be parent's children.
		*/
		var removedNodes : NodeList = parent.childNodes;

		/*
		Let addedNodes be the empty list if node is null, node's children if node is a DocumentFragment node, 
		and a list containing node otherwise.
		*/
		var addedNodes : NodeList;

		if (node == null) {

			addedNodes = [];
			
		} else if (node.nodeType == Node.DOCUMENT_FRAGMENT_NODE) {

			addedNodes = node.childNodes;

		} else {

			// addedNodes =  ???
			throw "not implemented";
		}

		/*
		Remove all parent's children, with the suppress observers flag set.
		*/
		// FIXME suppress observers flag
		for (c in removedNodes) {

			remove(c, parent);
		}

		/*
		If node is not null, insert node into parent before null with the suppress observers flag set.
		*/
		// if (node != null) { FIXME I disagree

		//	insert(node, parent, null);
		for (n in addedNodes) {

			insert(n, parent, null);
		}

		/*
		Queue a mutation record of "childList" for parent with addedNodes addedNodes and removedNodes removedNodes.
		*/
		// TODO

		/*
		Run node is removed for each node in removedNodes, in tree order, and then run node is inserted for each node 
		in addedNodes, in tree order.
		*/
		// TODO
	}

	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-node-append
	 */
	static public function append( node : Node, parent : Node ) : Node
	{
		return preInsert( node, parent, null );
	}

	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-node-pre-insert
	 */
	static public function preInsert( node : Node, parent : Node, child : Null<Node> ) : Node
	{
		if ( parent.nodeType != Node.DOCUMENT_NODE && parent.nodeType != Node.DOCUMENT_FRAGMENT_NODE && parent.nodeType != Node.ELEMENT_NODE  )
		{
			throw "HierarchyRequestError";
		}
		if ( isIncluseAncestor( node, parent ) )
		{
			throw "HierarchyRequestError";
		}
		if ( child != null && child.parentNode != parent )
		{
			throw  "NotFoundError";
		}
		if ( parent.nodeType == Node.DOCUMENT_NODE )
		{
			if ( node.nodeType != Node.DOCUMENT_FRAGMENT_NODE && node.nodeType != Node.DOCUMENT_TYPE_NODE && node.nodeType != Node.ELEMENT_NODE && 
					node.nodeType != Node.PROCESSING_INSTRUCTION_NODE && node.nodeType != Node.COMMENT_NODE )
			{
				throw "HierarchyRequestError";
			}
			if ( node.nodeType == Node.DOCUMENT_FRAGMENT_NODE )
			{
				if ( hasChild( node, Node.ELEMENT_NODE, 1 ) || hasChild( node, Node.TEXT_NODE ) )
				{
					throw "HierarchyRequestError";
				}
				if ( hasChild( node, Node.ELEMENT_NODE ) && 
					( hasChild( parent, Node.ELEMENT_NODE ) || child.nodeType == Node.DOCUMENT_TYPE_NODE || child != null && isFollowing( child, Node.DOCUMENT_TYPE_NODE ) ) )
				{
					throw "HierarchyRequestError";
				}
			}
			if ( node.nodeType == Node.ELEMENT_NODE &&
				( hasChild( parent, Node.ELEMENT_NODE ) || child != null && (child.nodeType == Node.DOCUMENT_TYPE_NODE || isFollowing( child, Node.DOCUMENT_TYPE_NODE)) ) )
			{
				throw "HierarchyRequestError";
			}
			if ( node.nodeType == Node.DOCUMENT_TYPE_NODE && 
				( hasChild( parent, Node.DOCUMENT_TYPE_NODE ) || child != null && isPreceding( child, Node.ELEMENT_NODE ) || child == null ) && 
					hasChild( parent, Node.ELEMENT_NODE ) )
			{
				throw "HierarchyRequestError";
			}
		}
		else if ( node.nodeType != Node.DOCUMENT_FRAGMENT_NODE && node.nodeType != Node.ELEMENT_NODE && node.nodeType != Node.TEXT_NODE && 
					node.nodeType != Node.PROCESSING_INSTRUCTION_NODE && node.nodeType != Node.COMMENT_NODE )
		{
			throw "HierarchyRequestError";
		}
		var refChild = child;

		if ( refChild == node )
		{
			refChild = node.nextSibling;
		}
		adopt( node, parent.ownerDocument );
		
		insert( node, parent, child );
		
		return node;
	}
	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-node-insert
	 */
	static public function insert( node : Node, parent : Node, child : Node ) : Void
	{
		var count : Int = node.nodeType == Node.DOCUMENT_FRAGMENT_NODE ? node.childNodes.length : 1;

		// TODO 2. For each range whose start node is parent and start offset is greater than child's index, 
		// increase its start offset by count.

		// TODO 3. For each range whose end node is parent and end offset is greater than child's index, 
		// increase its end offset by count.

		// 4. Let nodes be node's children if node is a DocumentFragment node, and a list containing solely node otherwise.
		var nodes : NodeList = node.nodeType == Node.DOCUMENT_FRAGMENT_NODE ? node.childNodes.copy() : [node];

		// TODO 5. If node is a DocumentFragment node, queue a mutation record of "childList" for node with removedNodes nodes.
		// Note: This step does intentionally not pay attention to the suppress observers flag.

		// 6. If node is a DocumentFragment node, remove its children with the suppress observers flag set.
		if (node.nodeType == Node.DOCUMENT_FRAGMENT_NODE) {

			for (c in node.childNodes) {

				remove(c, node);
			}
		}

		// TODO 7. If suppress observers flag is unset, queue a mutation record of "childList" for parent with addedNodes 
		// nodes, nextSibling child, and previousSibling child's previous sibling or parent's last child if child is null.

		// 8. Insert all nodes in nodes before child or at the end of parent if child is null.
		for (n in nodes) {

			if (child == null) {

				parent.childNodes.push(n);
			
			} else {

				var ci : Int = parent.childNodes.lastIndexOf(child);

				parent.childNodes.insert(ci, n);
			}
			n.parentNode = parent; // added to w3c algo, check if this isn't described elsewhere
		}

		// TODO 9. If suppress observers flag is unset, for each node in nodes, in tree order run node is inserted.
	}
	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-node-adopt
	 */
	static public function adopt( node : Node, ownerDocument : Document ) : Node
	{
		if ( node.parentNode != null )
		{
			remove( node, node.parentNode );
		}
		setNodeDocument( node, ownerDocument );

		return node;
	}
	/**
	 * Set a node's node document.
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-node-document
	 */
	static public function setNodeDocument( node : Node, ownerDocument : Document ) : Void
	{
		node.ownerDocument = ownerDocument;
		for ( cn in node.childNodes )
		{
			setNodeDocument( cn, ownerDocument );
		}
	}
	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-node-pre-remove
	 */
	static public function preRemove(child : Node, parent : Node) : Node
	{
		if ( child.parentNode != parent )
		{
			throw  "NotFoundError";
		}
		remove( child, parent );
		return child;
	}
	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-node-remove
	 * TODO? manage suppress observers flag
	 * TODO? manage ranges
	 */
	static public function remove( node : Node, parent : Node ) : Void
	{
		parent.childNodes.remove(node);
		
		node.parentNode = null; // added to w3c algo, check if this isn't described elsewhere

		//TODO? manage "node is removed" hook: https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#node-is-removed
	}
	/**
	 * Tells if a node has a previous sibling ( optionaly of a given type )
	 */
	static public function isPreceding( node : Node, ?typeFilter : Int ) : Bool
	{
		return ( previousSibling( node, typeFilter ) != null );
	}
	/**
	 * Returns node's previous sibling ( optionaly filter by type ).
	 */
	static public function previousSibling( node : Node, ?typeFilter : Int = -1 ) : Null<Node>
	{
		if ( node.parentNode == null || node.parentNode.childNodes.length <= 1 )
		{
			return null;
		}
		var ps : Null<Node> = null;
		for ( cn in node.parentNode.childNodes )
		{
			if ( cn == node )
			{
				if ( typeFilter != -1 && ps.nodeType != typeFilter )
				{
					return null;
				}
				return ps;
			}
			ps = cn;
		}
		return null;
	}
	/**
	 * Tells if a node has a next sibling ( optionaly of a given type )
	 */
	static public function isFollowing( node : Node, ?typeFilter : Int ) : Bool
	{
		return ( nextSibling( node, typeFilter ) != null );
	}
	/**
	 * Returns node's next sibling ( optionaly filter by type ).
	 */
	static public function nextSibling( node : Node, ?typeFilter : Int = -1 ) : Null<Node>
	{
		if ( node.parentNode == null || node.parentNode.childNodes.length <= 1 )
		{
			return null;
		}
		var f : Bool = false;
		for ( cn in node.parentNode.childNodes )
		{
			if ( f )
			{
				if ( typeFilter != -1 && cn.nodeType != typeFilter )
				{
					return null;
				}
				return cn;
			}
			f = (cn == node);
		}
		return null;
	}
	/**
	 * Tells if a node has a child ( optionaly of a given type )
	 */
	static public function hasChild( node : Node, ?typeFilter : Int = -1, ?moreThanCountFilter : Int = 0 ) : Bool
	{
		for ( cn in node.childNodes )
		{
			if ( typeFilter == -1 || cn.nodeType == typeFilter )
			{
				if ( moreThanCountFilter-- < 0 )
				{
					return true;
				}
			}
		}
		return false;
	}
	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-tree-ancestor
	 */
	static public function isAncestor( a : Node, d : Node ) : Bool
	{
		if ( d.parentNode == null )
		{
			return false;
		}
		if ( d.parentNode == a )
		{
			return true;
		}
		return isAncestor( a, d.parentNode );
	}
	/**
	 * @see https://dvcs.w3.org/hg/domcore/raw-file/tip/Overview.html#concept-tree-inclusive-ancestor
	 */
	static public function isIncluseAncestor( a : Node, d : Node ) : Bool
	{
		if ( a == d )
		{
			return true;
		}
		return isAncestor( a, d );
	}
	/**
	 * @see http://www.w3.org/TR/xml/#NT-Name
	 */
	static public function isValid( name : String, checkLevel : String ) : Bool
	{
		//TODO implement checks
		return true;
	}
	/**
	 * Get the first attr of a node (optionaly with a name filter)
	 */
	static public function firstAttr( node : Element, ?name : Null<String> = null ) : Null<Attr>
	{
		for ( at in node.attributes )
		{
			if ( name == null || at.name == name )
			{
				return at;
			}
		}
		return null;
	}

	///
	// ATTRIBUTES
	//

	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-element-attributes-change
	 */
	static public function changeAttr(attribute : Attr, element : Element, value : String) : Void {
		
		// FIXME Queue a mutation record of "attributes" for element with name attribute's local name, 
		// namespace attribute's namespace, and oldValue attribute's value.

		attribute.value = value;

		// FIXME hooks for "an attribute" is set and "an attribute is changed".
	}
	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-element-attributes-append
	 */
	static public function appendAttr(attribute : Attr, element : Element) : Void {

		// FIXME Queue a mutation record of "attributes" for element with name attribute's local name, 
		// namespace attribute's namespace, and oldValue null.

		element.attributes.push(attribute);

		// FIXME hooks for "an attribute is set" and "an attribute is added".
	}
	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-element-attributes-remove
	 */
	static public function removeAttr(attribute : Attr, element : Element) : Void {

		// FIXME Queue a mutation record of "attributes" for element with name attribute's local name, 
		// namespace attribute's namespace, and oldValue attribute's value.

		element.attributes.remove(attribute);

		// FIXME hook for "an attribute is removed".
	}

	///
	// LISTS OF ELEMENTS
	//

	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-getelementsbyclassname
	 * 
	 * TODO When invoked with the same argument, the same HTMLCollection object may be returned 
	 * as returned by an earlier call.
	 */
	static public function listOfElementWithClassNames(classNames : String, root : Node) : HTMLCollection {

		var classes : Array<String> = parseOrderedSet(classNames);

		if (classes.length > 0) {

			return getFilteredList(root, function(n : Node) {

					if (n.nodeType != Node.ELEMENT_NODE) {

						return false;
					}
					var e : Element = Std.instance(root, Element);
					var ec : Array<String> = parseOrderedSet(e.className);

					for (c in classNames) {

						// FIXME If root's node document is in quirks mode, then the comparisons 
						// for the classes must be done in an ASCII case-insensitive manner, and 
						// in a case-sensitive manner otherwise.
						if (!ec.has(c)) {

							return false;
						}
					}
					return  true;
				});
		}
		return new HTMLCollection();
	}

	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-getelementsbytagname
	 * 
	 * TODO When invoked with the same argument, the same HTMLCollection object may be returned 
	 * as returned by an earlier call.
	 */
	static public function listOfElementsWithLocalName(localName : String, root : Node) : HTMLCollection {

		if (localName == DOMConstants.MATCH_ALL_TAG_NAME) {

			return getFilteredList(root, function(n : Node) { return n.nodeType == Node.ELEMENT_NODE; });
		}

		// TODO Otherwise, if root's node document is an HTML document, return a HTMLCollection rooted at root, whose filter matches only the following elements:
	#if strict
        throw "Not implemented!";
    #end
			// Whose namespace is the HTML namespace and whose local name is localName converted to ASCII lowercase.

			// Whose namespace is not the HTML namespace and whose local name is localName.
		
		return getFilteredList(root, function(n : Node) { return n.nodeType == Node.ELEMENT_NODE && n.localName == localName; });
	}

	/**
	 * Generates an HTMLCollection by appending it in tree order the Elements matching the given 
	 * filter in the root node and its children.
	 *
	 * This method is not described in the specs.
	 */
	static public function getFilteredList(root : Node, filter : Node -> Bool) : HTMLCollection {

		var ret : HTMLCollection = new HTMLCollection();

		for (i in 0...root.childNodes.length) {

			if (filter(root.childNodes[i])) {

				ret.push(root.childNodes[i]);

				ret = ret.concat(getFilteredList(root.childNodes[i], filter));
			}
		}
		return ret;
	}

	///
	// DATA
	//

	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-cd-substring
	 */
	static public function substringData(node : CharacterData, offset : Int, count : Int) : String {

		var length : Int = node.length;

		if ( offset > length ) {

			throw new DOMException(DOMException.INDEX_SIZE_ERR);
		}
		if (offset + count > length) {

			return node.data.substr(offset - 1);
		}
		return node.data.substr(offset - 1, count);
	}
	
	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-cd-replace
	 */
	static public function replaceData(node : CharacterData, offset : Int, count : Int, data : String) : Void {

		var l = node.length;
		
		if ( offset > l ) {

			throw new DOMException(DOMException.INDEX_SIZE_ERR);
		}
		if ( offset + count > l ) {

			count = l - offset;
		}
		// Not implemented: Queue a mutation record of "characterData" for node with oldValue node's data. 
		
		node.data = node.data.substr( 0, offset ) + data + node.data.substr( offset );
		
		var delOffset = offset + data.length;
		
		node.data = node.data.substr( 0, delOffset ) + node.data.substr(delOffset + count);
		
		// FIXME
		// For each range whose start node is node and start offset is greater than offset but less than or 
		// equal to offset plus count, set its start offset to offset.

		// FIXME
		// For each range whose end node is node and end offset is greater than offset but less than or equal 
		// to offset plus count, set its end offset to offset.

		// FIXME
		// For each range whose start node is node and start offset is greater than offset plus count, 
		// increase its start offset by the number of code units in data, then decrease it by count.

		// FIXME
		// For each range whose end node is node and end offset is greater than offset plus count, increase 
		// its end offset by the number of code units in data, then decrease it by count.
	}

	///
	// STRINGS
	//

	/**
	 * @ see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-ordered-set-serializer
	 */
	static public function serializeOrderedSet(input : Array<String>) : String {

		return input.join(" ");
	}

	/**
	 * @see http://www.w3.org/TR/2014/CR-dom-20140508/#concept-ordered-set-parser
	 */
	static public function parseOrderedSet(input : String) : Array<String> {

		var p : Int = 0;
		var tokens : Array<String> : [];
		var currentToken : String = "";

		while (p < input.length) {

			var c : String : input.charAt(p);

			if (c != " ") {

				currentToken += c;
			
			} else {

				if (currentToken != "") {

					if (!tokens.has(currentToken)) {

						tokens.push(currentToken);
					}
					currentToken = "";
				}
			}
			p++;
		}
	}
}