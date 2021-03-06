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
    	this.elt7 = document.createElement("e");
        this.text1 = document.createTextNode("Test Cocktail Text Content");
        this.text2 = document.createTextNode("Test Cocktail Text Content 2");

    	document.appendChild(elt2);
    	elt2.appendChild(elt3);
        elt2.appendChild(elt4);
    	elt2.appendChild(text2);
    	elt4.appendChild(elt5);
        elt4.appendChild(elt6);
        elt4.appendChild(text1);
    	elt4.appendChild(elt7);
    	elt5.appendChild(elt);
    }

    var document : Document;
    var elt : Element;
    var elt2 : Element;
    var elt3 : Element;
    var elt4 : Element;
    var elt5 : Element;
    var elt6 : Element;
    var elt7 : Element;
    var text1 : Text;
    var text2 : Text;

    @Test
    public function testElementCreation()
    {
        Assert.isTrue(elt != null && elt2 != null && elt3 != null && elt4 != null && elt5 != null && elt6 != null && elt7 != null);
        Assert.isTrue(elt != elt2 && elt2 != elt3 && elt3 != elt4 && elt4 != elt5 && elt5 != elt6 && elt6 != elt7);
    }

    @Test
    public function testChildNodes()
    {
        Assert.isTrue(elt.childNodes.length == 0);
        Assert.isTrue(elt2.childNodes.length == 3);
        Assert.isTrue(elt3.childNodes.length == 0);
        Assert.isTrue(elt4.childNodes.length == 4);
        Assert.isTrue(elt5.childNodes.length == 1);
        Assert.isTrue(elt6.childNodes.length == 0);
        Assert.isTrue(elt7.childNodes.length == 0);
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
