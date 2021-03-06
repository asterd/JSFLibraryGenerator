/*
 * generated by Xtext
 */
package de.beyondjava.xtext.jsf.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class ComponentLanguageGenerator implements IGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		new TaglibGenerator().doGenerate(resource, fsa);
		new ComponentGenerator().doGenerate(resource, fsa);
		new RendererGenerator().doGenerate(resource, fsa);
		new DocumentationGenerator().doGenerate(resource, fsa);
		new AttributesDocumentationGenerator().doGenerate(resource, fsa);
		new BeanInfoGenerator().doGenerate(resource, fsa);
	}

}