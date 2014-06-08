package ;

import cocktail.dom.Attr;
import cocktail.dom.CharacterData;
import cocktail.dom.Comment;
import cocktail.dom.Document;
import cocktail.dom.DocumentFragment;
import cocktail.dom.DocumentType;
import cocktail.dom.DOMConstants;
import cocktail.dom.DOMException;
import cocktail.dom.DOMImplementation;
import cocktail.dom.DOMSettableTokenList;
import cocktail.dom.DOMTokenList;
import cocktail.dom.DOMTools;
import cocktail.dom.Element;
import cocktail.dom.HTMLCollection;
import cocktail.dom.Node;
import cocktail.dom.NodeList;
import cocktail.dom.ProcessingInstruction;
import cocktail.dom.Text;

import massive.munit.Assert;

class DomTest
{
    public function new() { }

    @Before
    public function setup():Void
    {
    	this.document = new Document();

    	this.elt = document.createElement("a");

    	elt.id = "elt1";
    	elt.className = "testElt";

    	this.elt2 = document.createElement("b");
    	this.elt3 = document.createElement("c");
    	elt3.className = "testElt2";
    	this.elt4 = document.createElement("d");
    	elt4.className = "testElt";
    	this.elt5 = document.createElement("d");
    	elt5.className = "testElt2";
    	this.elt6 = document.createElement("e");

    	document.appendChild(elt2);
    	elt2.appendChild(elt3);
    	elt2.appendChild(elt4);
    	elt4.appendChild(elt5);
    	elt4.appendChild(elt6);
    	elt5.appendChild(elt);
    }

    var document : Document;
    var elt : Element;
    var elt2 : Element;
    var elt3 : Element;
    var elt4 : Element;
    var elt5 : Element;
    var elt6 : Element;

    @Test
    public function testDocumentGetElementById()
    {
    	var r : Element = document.getElementById("elt1");

    	Assert.isTrue(r == elt);
    }

    @Test
    public function testDocumentGetElementsByTagName()
    {
    	var r : HTMLCollection = document.getElementsByTagName("a");
    	var r2 : HTMLCollection = document.getElementsByTagName("d");

    	Assert.isTrue(r.length == 1);
    	Assert.isTrue(r2.length == 2);
    	Assert.isTrue(r[0] == elt);
    	Assert.isTrue(r2[0] == elt4);
    	Assert.isTrue(r2[1] == elt5);
    }

    @Test
    public function testDocumentGetElementsByClassName()
    {
    	var r : HTMLCollection = document.getElementsByClassName("testElt");

    	Assert.isTrue(r.length == 2);
    	Assert.isTrue(r[0] == elt4);
    	Assert.isTrue(r[1] == elt);
    }
}
