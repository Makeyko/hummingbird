/////////////////////////////////////////////////////////////////////////////////////
//
//    Simplified BSD License
//    ======================
//    
//    Copyright 2013 Pascal ECHEMANN. All rights reserved.
//    
//    Redistribution and use in source and binary forms, with or without modification,
//    are permitted provided that the following conditions are met:
//    
//    1. Redistributions of source code must retain the above copyright notice, this
//       list of conditions and the following disclaimer. 
//    
//    2. Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution. 
//    
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//    
//    The views and conclusions contained in the software and documentation are those
//    of the authors and should not be interpreted as representing official policies, 
//    either expressed or implied, of the copyright holders.
//    
/////////////////////////////////////////////////////////////////////////////////////

package org.flashapi.hummingbird {
	
	// -----------------------------------------------------------
	//  Hummingbird.as
	// -----------------------------------------------------------

	/**
	 *  @author Pascal ECHEMANN
	 *  @version 2.0.0, 26/10/2013 23:22
	 *  @see http://www.flashapi.org/
	 */

import feathers.controls.Drawers;
import feathers.controls.Screen;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;

import flash.display.Stage;
	import flash.utils.Dictionary;
	import org.flashapi.hummingbird.core.HummingbirdBase;
	import org.flashapi.hummingbird.core.HummingbirdEventDispatcher;
	import org.flashapi.hummingbird.core.HummingbirdVersion;
	import org.flashapi.hummingbird.core.IApplicationContext;
	import org.flashapi.hummingbird.events.StarlingContextEvent;
	import org.flashapi.hummingbird.events.StarlingDependencyEvent;
	import org.flashapi.hummingbird.exceptions.StarlingIDException;
	import org.flashapi.hummingbird.factory.IDefinitionRegistry;
	import org.flashapi.hummingbird.factory.IFactory;
	import org.flashapi.hummingbird.logging.ILogger;
	import org.flashapi.hummingbird.starling.core.StarlingContextMapDto;
	import org.flashapi.hummingbird.starling.core.StarlingMapDto;
	import org.flashapi.hummingbird.starling.StarlingID;
	import org.flashapi.hummingbird.starling.StarlingProperties;
	import org.flashapi.hummingbird.utils.MetadataParser;
	import org.flashapi.hummingbird.view.IView;
	import org.flashapi.hummingbird.view.RootDisplayObject;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * 	The <code>Hummingbird</code> class represents the core of the Hummingbird
	 * 	framework for Starling-framework-based applications development.
	 */
	public class HummingbirdFeathers extends HummingbirdBase {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the reference to the Hummingbird framework internal logger.
		 * 
		 * 	@return The Hummingbird framework internal logger.
		 */
		public static function getLogger():ILogger {
			return HummingbirdBase.getLogger();
		}
		
		/**
		 * 	Adds the specified application context to the Hummingbird IoC container.
		 * 
		 * 	@param	applicationContext	The applicationcontext to add to the
		 * 								Hummingbird IoC container.
		 * 	@param	stage				A reference to the Flash Player <code>Stage</code>
		 * 								instance.
		 * 	@param	properties			An object that contains properties for initializing
		 * 								the built-in <code>Starling</code> instance.
		 * 
		 * 	@return The <code>StarlingID</code> instance associated to the specified
		 * 			<code>stage</code> parameter. If <code>stage</code> is <code>null</code>,
		 * 			returns the <code>StarlingID</code> instance associated to the initial
		 * 			<code>Stage</code> instance.
		 */
		public static function setApplicationContext(
												applicationContext:IApplicationContext,
												stage:Stage = null,
												properties:StarlingProperties = null):StarlingID {
			return HummingbirdFeathers.initStarling(applicationContext, properties, stage);
		}
		
		/**
		 * 	Clears and removes the specified context from the Hummingbird IoC
		 * 	container.
		 * 
		 * 	@param	applicationContext	The applicationcontext to remove from the
		 * 								Hummingbird IoC container.
		 * 	@param	disposeMvcObjects	Indicates whether the IoC container must
		 * 								delete all the references of the MVC objects
		 * 								associated to the specified context (<code>true</code>),
		 * 								or not (<code>true</code>). The default value
		 * 								is <code>true</code>.
		 */
		public static function clearApplicationContext(applicationContext:IApplicationContext, disposeMvcObjects:Boolean = true):void {
			HummingbirdBase.clearApplicationContext(applicationContext, disposeMvcObjects);
		}
		
		/**
		 * 	Adds the specified view to the scene.
		 * 
		 * 	@param	screenId		The view to add to the scene.
		 * 
		 * 	@throws org.flashapi.hummingbird.exceptions.StarlingIDException
		 * 			Throws a <code>StarlingIDException</code> exception if the
		 * 			specified <code>StarlingID</code> object is not registered.
		 */

		public static function showScreen(screenId:String):DisplayObject {
            return HummingbirdFeathers.getNavigator().showScreen(screenId);
		}
		
		/**
		 * 	Removes the specified view from the scene.
		 * 
		 * 	@param	view		The view to remove from the scene.
		 * 
		 * 	@throws org.flashapi.hummingbird.exceptions.StarlingIDException
		 * 			Throws a <code>StarlingIDException</code> exception if the
		 * 			specified <code>StarlingID</code> object is not registered.
		 * 
		 * 	@see #clearScene()
		 */
		public static function removeFromScene(view:IView):void {
            HummingbirdFeathers.getNavigator().removeChild(DisplayObject(view));
		}
		
        public static function addScreen(screenID:String, screenClass:Object):void {
             HummingbirdFeathers.getNavigator().addScreen(screenID, new ScreenNavigatorItem(screenClass));
        }


		public static function sceneContains(view:IView):Boolean {
			return HummingbirdFeathers.getNavigator().contains(DisplayObject(view));
		}

		public static function clearScene():void {
			HummingbirdFeathers.getNavigator().clearScreen();
		}
		
		/**
		 * 	Returns a reference to the Flash Player <code>Stage</code> instance.
		 * 
		 * 	@param starlingID	The <code>StarlingID</code> used to specifiy
		 * 						which stage reference to use for this operation.
		 * 						If <code>null</code> the stage reference to use
		 * 						to perform the operation is the main application
		 * 						stage.
		 * 	
		 * 	@return The Flash Player <code>Stage</code> instance.
		 * 
		 * 	@throws org.flashapi.hummingbird.exceptions.StarlingIDException
		 * 			Throws a <code>StarlingIDException</code> exception if the
		 * 			specified <code>StarlingID</code> object is not registered.
		 */
		public static function getStage(starlingID:StarlingID = null):Stage {
			var guid:String = HummingbirdFeathers.getGUID(starlingID);
			return HummingbirdFeathers.getStarlingMapDto(guid).stage;
		}
		
		/**
		 * 	Returns a reference to the <code>IFactory</code> instance associated
		 * 	with the Hummingbird IoC container.
		 * 	
		 * 	@return The <code>IFactory</code> instance associated with the
		 * 			Hummingbird IoC container.
		 */
		public static function getFactory():IFactory {
			return HummingbirdBase.getFactory();
		}
		
		/**
		 * 	Returns a reference to the <code>IDefinitionRegistry</code> instance 
		 * 	associated with the Hummingbird IoC container.
		 * 
		 * 	
		 * 	@return The <code>IDefinitionRegistry</code> instance associated with 
		 * 			the Hummingbird IoC container.
		 */
		public static function getDefinitionRegistry():IDefinitionRegistry {
			return HummingbirdBase.getDefinitionRegistry();
		}
		
		/**
		 * 	Returns a reference to the <code>Starling</code> instance associated
		 * 	with the Hummingbird IoC container.
		 * 
		 * 	@param starlingID	The <code>StarlingID</code> used to specifiy
		 * 						which <code>Starling</code> instance to
		 * 						return. If <code>null</code> the returend
		 * 						<code>Starling</code> instance is the initial
		 * 						<code>Starling</code> object.
		 * 	
		 * 	@return A <code>Starling</code> instance associated with the
		 * 			Hummingbird IoC container.
		 * 
		 * 	@throws org.flashapi.hummingbird.exceptions.StarlingIDException
		 * 			Throws a <code>StarlingIDException</code> exception if the
		 * 			specified <code>StarlingID</code> object is not registered.
		 */
		public static function getStarling(starlingID:StarlingID = null):Starling {
			var guid:String = HummingbirdFeathers.getGUID(starlingID);
			return HummingbirdFeathers.getStarlingID(guid).getStarling();
		}
		
		/**
		 * 	Deletes the reference to the specified <code>StarlingID</code> instance.
		 * 
		 * 	@param starlingID	The <code>StarlingID</code> used to specifiy
		 * 						which <code>Starling</code> instance to
		 * 						remove. If <code>null</code> the removed
		 * 						<code>Starling</code> instance is the initial
		 * 						<code>Starling</code> object.
		 * 
		 * 	@return	The <code>Starling</code> instance associated to the deleted 
		 * 			<code>StarlingID</code> object.
		 */
		public static function removeStarling(starlingID:StarlingID):Starling {
			return HummingbirdFeathers.deleteStarlingReference(starlingID);
		}
		
		/**
		 * 	Returns the object that exposes the current Hummingbird version.
		 * 
		 * 	@return	The object that exposes the current Hummingbird version.
		 */
		public static function getVersion():HummingbirdVersion {
			return HummingbirdBase.getVersion();
		}
		
		/**
		 * 	Returns the Hummingbird event dispatcher singleton.
		 * 
		 * 	@return	The Hummingbird event dispatcher singleton.
		 */
		public static function getEventDispatcher():HummingbirdEventDispatcher {
			return HummingbirdBase.getEventDispatcher();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	A map used to store and manage the different <code>Starling</code> 
		 * 	instances and their associated <code>Stage</code> instances.
		 */
		private static var _starlingMap:Dictionary = new Dictionary();
		
		/**
		 * 	@private
		 * 
		 * 	A collection used manage the delayed creation of the different context 
		 * 	related to a specific <code>Starling</code> instances.
		 */
		private static var _contextCollection:Vector.<StarlingContextMapDto> =
			new Vector.<StarlingContextMapDto>();
		
		/**
		 * 	@private
		 * 
		 * 	A reference to the initial <code>Starling</code> instances.
		 * 
		 * 	@default null
		 */
		private static var _initialStarlingGUID:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Initializes a built-in <code>Starling</code> instance if necessary and
		 * 	sets the specified application context.
		 * 
		 * 	@param	applicationContext	The applicationcontext to add to the
		 * 								Hummingbird IoC container.
		 * 	@param	properties			An object that contains properties for initializing
		 * 								the built-in <code>Starling</code> instance.
		 * 	@param	stage				A reference to the Flash Player <code>Stage</code>
		 * 								instance.
		 * 
		 * 	@return The <code>StarlingID</code> instance associated to the specified
		 * 			<code>stage</code> parameter. If <code>stage</code> is <code>null</code>,
		 * 			returns the <code>StarlingID</code> instance associated to the initial
		 * 			<code>Stage</code> instance.
		 */
		private static function initStarling(	applicationContext:IApplicationContext,
												properties:StarlingProperties,
												stage:Stage
												):StarlingID {
			var logger:ILogger = HummingbirdBase.getLogger();
			MetadataParser.setStarlingEventRef(StarlingDependencyEvent);
			var starlingId:StarlingID;
			if (stage != null) {
				logger.config("Starling framework initialization");
				var starling:Starling;
				var isStarlingUndefined:Boolean = (HummingbirdFeathers._initialStarlingGUID == null);
				if (properties) {
					logger.config("Starling framework instanciation");
					if (isStarlingUndefined) {
						Starling.handleLostContext = properties.handleLostContext;
						Starling.multitouchEnabled = properties.multitouchEnabled;
					}
					starling = new Starling(RootDisplayObject, stage,
						properties.viewPort,
						properties.stage3D,
						properties.renderMode,
						properties.profile
					);
					HummingbirdFeathers._contextCollection.push(
						HummingbirdFeathers.createStarlingContextMapDto(starling, applicationContext)
					);
					logger.config("Starling properties initialization");
					starling.antiAliasing = properties.antiAliasing;
					starling.enableErrorChecking = properties.enableErrorChecking;
					starling.simulateMultitouch = properties.simulateMultitouch;
					starling.shareContext = properties.shareContext;
					starling.antiAliasing = properties.antiAliasing;
					starling.showStats = properties.showStats;
				} else {
					logger.config("Starling framework instanciation");
					starling = new Starling(RootDisplayObject, stage);
					HummingbirdFeathers._contextCollection.push(
						HummingbirdFeathers.createStarlingContextMapDto(starling, applicationContext)
					);
				}
				starling.addEventListener(Event.ROOT_CREATED, HummingbirdFeathers.rootCreatedHandler);
				starlingId = new StarlingID(starling);
				var guid:String = starlingId.getGUID();
				HummingbirdFeathers._starlingMap[guid] = HummingbirdFeathers.createStarlingMapDto(starlingId, stage);
				if (isStarlingUndefined) {
					HummingbirdFeathers._initialStarlingGUID = guid;
				}
			} else {
				if (HummingbirdFeathers._initialStarlingGUID != null) {
					starlingId = HummingbirdFeathers.getStarlingID(HummingbirdFeathers._initialStarlingGUID);
					HummingbirdBase.setApplicationContext(applicationContext);
				} else {
					logger.warn("Starling framework has not been instanciated");
					HummingbirdFeathers._contextCollection.push(
						HummingbirdFeathers.createStarlingContextMapDto(null, applicationContext)
					);
				}
			}
			return starlingId;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Invoked when the Starling root class is added to the stage.
		 * 
		 * 	@param	e	The reference to the triggered event.
		 */
		private static function rootCreatedHandler(e:Event):void {
			HummingbirdBase.getLogger().config("Starling root object created");
			var target:Starling = e.target as Starling;
			target.removeEventListener(Event.ROOT_CREATED, HummingbirdFeathers.rootCreatedHandler);
			var dto:StarlingContextMapDto;
			var starlingRef:Starling;
			var i:int = 0;
			for (; i <= HummingbirdFeathers._contextCollection.length - 1; ++i) {
				dto = HummingbirdFeathers._contextCollection[i];
				starlingRef = dto.starling
				if (starlingRef == null || starlingRef == target) {
					HummingbirdBase.setApplicationContext(dto.context);
					HummingbirdFeathers._contextCollection.splice(i, 1);
					--i;
					dto.finalize();
					dto = null;
				}
			}
			var evt:StarlingContextEvent = new StarlingContextEvent(StarlingContextEvent.ROOT_CREATION_COMPLETE);
			HummingbirdBase.getEventDispatcher().dispatchEvent(evt);
		}

        private static var _navigator:ScreenNavigator;

        public static function getNavigator():ScreenNavigator {
            return _navigator;
        }

        public static function initScreenNavigator(starlingID:StarlingID = null) {
            _navigator = new ScreenNavigator();
            HummingbirdFeathers.getRootClass(starlingID).addChild(_navigator);
        }

        public static function addDrawer(drawers:Drawers,starlingID:StarlingID = null) {
            HummingbirdFeathers.getRootClass(starlingID).addChild(drawers);
            drawers.content = getNavigator();

        }
		
		/**
		 * 	@private
		 * 
		 * 	Creates and returns a new instance of the <code>StarlingMapDto</code> class.
		 * 
		 * 	@param	starlingId	The <code>starlingId</code> parameter of the new
		 * 						<code>StarlingMapDto</code> instance.
		 * 	@param	stage		The <code>stage</code> parameter of the new
		 * 						<code>StarlingMapDto</code> instance.
		 * 
		 * 	@return	A new instance of the <code>StarlingMapDto</code> class.
		 */
		private static function createStarlingMapDto(starlingId:StarlingID, stage:Stage):StarlingMapDto {
			var dto:StarlingMapDto = new StarlingMapDto();
			dto.starlingID = starlingId;
			dto.stage = stage;
			return dto;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Creates and returns a new instance  the <code>StarlingContextMapDto</code>
		 * 	class.
		 * 
		 * 	@param	starling	The <code>starling</code> parameter of the new
		 * 						<code>StarlingContextMapDto</code> instance.
		 * 	@param	context		The <code>context</code> parameter of the new
		 * 						<code>StarlingContextMapDto</code> instance.
		 * 
		 * 	@return	A new instance of the <code>StarlingContextMapDto</code> class.
		 */
		private static function createStarlingContextMapDto(starling:Starling, context:IApplicationContext):StarlingContextMapDto {
			var dto:StarlingContextMapDto = new StarlingContextMapDto();
			dto.starling = starling;
			dto.context = context;
			return dto;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Returns the <code>StarlingID</code> instance with the specified GUID.
		 * 
		 * 	@param	guid	The GUID of the <code>StarlingID</code> instance to
		 * 					find.
		 * 
		 * 	@return	The <code>StarlingID</code> instance with the specified GUID.
		 * 
		 * 	@throws org.flashapi.hummingbird.exceptions.StarlingIDException
		 * 			Throws a <code>StarlingIDException</code> exception if the
		 * 			specified GUID is not registered.
		 */
		private static function getStarlingID(guid:String):StarlingID {
			return HummingbirdFeathers.getStarlingMapDto(guid).starlingID;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Returns the <code>StarlingMapDto</code> instance with the specified
		 * 	GUID.
		 * 
		 * 	@param	guid	The GUID of the <code>StarlingMapDto</code> instance 
		 * 					to find.
		 * 
		 * 	@return	The <code>StarlingMapDto</code> instance with the specified
		 * 			GUID.
		 * 
		 * 	@throws org.flashapi.hummingbird.exceptions.StarlingIDException
		 * 			Throws a <code>StarlingIDException</code> exception if the
		 * 			specified GUID is not registered.
		 */
		private static function getStarlingMapDto(guid:String):StarlingMapDto {
			var mapDto:StarlingMapDto = HummingbirdFeathers._starlingMap[guid];
			if (mapDto == null) {
				throw new StarlingIDException("No StarlingID object registered with the GUID " + guid);
			}
			return mapDto;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Returns the <code>RootDisplayObject</code> object associated to the
		 * 	specified <code>StarlingID</code> instance.
		 * 
		 * 	@param	starlingId	The <code>StarlingID</code> instance for which to 
		 * 						return the root.
		 * 
		 * 	@return	The root of the specified <code>StarlingID</code> object.
		 */
		private static function getRootClass(starlingId:StarlingID):RootDisplayObject {
			var starling:Starling = HummingbirdFeathers.getStarling(starlingId);
			var rootClass:RootDisplayObject = starling.root as RootDisplayObject;
			return rootClass;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Returns the GUID associated to the specified <code>StarlingID</code>
		 * 	instance.
		 * 
		 * 	@param	starlingId	The <code>StarlingID</code> instance for which to 
		 * 						return the GUID.
		 * 
		 * 	@return	The GUID of the specified <code>StarlingID</code> object.
		 */
		private static function getGUID(starlingId:StarlingID):String {
			var guid:String = (starlingId == null) ?
				HummingbirdFeathers._initialStarlingGUID : starlingId.getGUID();
			return guid;
		}
		
		/**
		 * 	@private
		 * 
		 * 	Deletes the reference to the specified <code>StarlingID</code> instance.
		 * 
		 * 	@param	starlingID	The <code>StarlingID</code> instance for which to 
		 * 						delete the reference.
		 * 
		 * 	@return	The <code>Starling</code> instance associated to the deleted 
		 * 			<code>StarlingID</code> object.
		 */
		private static function deleteStarlingReference(starlingID:StarlingID):Starling {
			var guid:String = starlingID.getGUID();
			var mapDto:StarlingMapDto = HummingbirdFeathers._starlingMap[guid];
			var starlingID:StarlingID =  mapDto.starlingID;
			var starling:Starling = starlingID.getStarling();
			starlingID.finalize();
			mapDto.finalize();
			delete mapDto[guid];
			starlingID = null;
			mapDto = null;
			if (guid == HummingbirdFeathers._initialStarlingGUID) {
				HummingbirdFeathers._initialStarlingGUID = null;
				HummingbirdBase.getLogger().warn("Initial Starling instance removed");
			}
			return starling;
		}
	}
}