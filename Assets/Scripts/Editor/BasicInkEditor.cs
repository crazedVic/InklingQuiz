﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using Ink.UnityIntegration;
using Ink.Runtime;

[CustomEditor(typeof(StoryController))]
[InitializeOnLoad]
public class BasicInkEditor : Editor {

    static BasicInkEditor () {
        StoryController.OnCreateStory += OnCreateStory;
    }

    static void OnCreateStory (Story story) {
        // If you'd like NOT to automatically show the window and attach (your teammates may appreciate it!) then replace "true" with "false" here. 
        InkPlayerWindow window = InkPlayerWindow.GetWindow(true);
        if(window != null) InkPlayerWindow.Attach(story);
    }
	public override void OnInspectorGUI () {
		Repaint();
		base.OnInspectorGUI ();
		var realTarget = target as StoryController;
		var story = realTarget.story;
		InkPlayerWindow.DrawStoryPropertyField(story, new GUIContent("Story"));
	}
}
