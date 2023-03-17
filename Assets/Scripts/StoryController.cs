using UnityEngine;
using UnityEngine.UI;
using System;
using Ink.Runtime;
using System.Collections.Generic;

// This is a super bare bones example of how to play and display a ink story in Unity.
public class StoryController : MonoBehaviour {
    public static event Action<Story> OnCreateStory;

	[SerializeField]
	private TextAsset inkJSONAsset = null;
	public Story story;

	[SerializeField]
	private RectTransform leftCanvas = null;

	[SerializeField]
	private RectTransform rightCanvas = null;

	[SerializeField]
	private RectTransform answerCanvas = null;

	[SerializeField]
	private GameObject highScorePanel = null;

	// UI Prefabs
	[SerializeField]
	private Text textPrefab = null;
	[SerializeField]
	private Button buttonPrefab = null;
	[SerializeField]
	private InputField inputFieldPrefab = null;
	[SerializeField]
	private Text Score;

	// Label Mgmt
	private string currentRole = "teacher"; // this will be updated anytime a role changes in the ink file
								// we assume that unless there's a new role or mood, we use the last one we found.
	private string currentMood = "neutral"; // same with mood, last one persists.

	private string latestChoice = ""; // going to see if i can store last choice made

	private string username = "";

	void Awake () {
		GetUserName();
		
	}

	private void GetUserName()
    {
		// here add text to left canvas asking user their name
		// then add input box to right canvas
		// user name should be submitted on Enter
		Text usernamePrompt = Instantiate(textPrefab) as Text;
		usernamePrompt.text = "What is your name?";
		usernamePrompt.transform.SetParent(leftCanvas.transform, false);
		InputField inputField = Instantiate(inputFieldPrefab) as InputField;
		inputField.onSubmit.AddListener(onSubmitName);
		inputField.transform.SetParent(rightCanvas.transform, false);
	}
    private void Update()
    {
		answerCanvas.gameObject.SetActive(latestChoice != "");
		rightCanvas.gameObject.SetActive(rightCanvas.childCount > 0);
		leftCanvas.gameObject.SetActive(leftCanvas.childCount > 0);
	}

    // Creates a new Story object with the compiled story which we can then play!
    void StartStory () {
		story = new Story (inkJSONAsset.text);
        if(OnCreateStory != null) OnCreateStory(story);
		story.ObserveVariable("total_score", (variableName, newValue) =>
		{
			// Print the new value
			if(newValue!=null)
				Score.text = $"{(int)newValue}";
		});
		RefreshView(false);
	}

	private void ParseTags(List<string> currentTags)
	{
		string oldMood = currentMood;
		string oldRole = currentRole;
		foreach (string tag in currentTags)
		{
			string[] splitTag = tag.Split(":");
			if (splitTag.Length == 2)
			{
				string tagKey = splitTag[0].Trim();
				string tagValue = splitTag[1].Trim();

				switch (tagKey)
				{
					case "mood":
						currentMood = tagValue;
						break;
					case "role":
						currentRole = tagValue;
						break;
					default:
						Debug.LogWarning($"unhandled Tag found:{tagKey}");
						break;
				}
			}
		}
		if (currentMood != oldMood)
        {
			Debug.Log($"Mood changed from {oldMood} to {currentMood}");
        }

		if (currentRole != oldRole)
		{
			Debug.Log($"Mood changed from {oldRole} to {currentRole}");
		}
	}
	
	// This is the main function called every time the story changes. It does a few things:
	// Destroys all the old content and choices.
	// Continues over all the lines of text, then displays all the choices. If there are no choices, the story is finished!
	void RefreshView (bool clearScreen = true) {
		// Remove all the UI on screen
		if (clearScreen)
        {
			RemoveChildrenLeft();
			RemoveChildrenRight();
		}
		
		// Read all the content until we can't continue any more
		while (story.canContinue) {
			// Continue gets the next line of the story
			string text = story.Continue ();
			// This removes any white space from the text.
			text = text.Trim();

			List<string> tags = story.currentTags;
			ParseTags(tags);
			// Display the text on screen!
			CreateContentView(text);
		}

		// Display all the choices, if there are any!
		if(latestChoice != "")
        {
			RemoveChildrenAnswer();
			Text storyText = Instantiate(textPrefab) as Text;
			storyText.text = latestChoice + "?";
			storyText.transform.SetParent(answerCanvas.transform, false);
		}

        if (story.currentChoices.Count > 0) {
			for (int i = 0; i < story.currentChoices.Count; i++) {
				Choice choice = story.currentChoices [i];
				Button button = CreateChoiceView (choice.text.Trim ());
				// Tell the button what to do when we press it
				button.onClick.AddListener (delegate {
					OnClickChoiceButton (choice);
				});
			}
		}
		// If we've read all the content and there's no choices, the story is finished!
		else {
			currentRole = "student";
			Button button = CreateChoiceView("How did I do?");
			button.onClick.AddListener(delegate {
				ShowScores();
			});
		}
	}

	void ShowScores()
    {
		highScorePanel.SetActive(true);
    }
	// When we click the choice button, tell the story to choose that choice!
	void OnClickChoiceButton (Choice choice) {
		latestChoice = choice.text;
		story.ChooseChoiceIndex (choice.index);
		RefreshView();
	}

	// Creates a textbox showing the the line of text
	void CreateContentView (string text) {
		if (text.Trim().Length == 0)
			return;
		Text storyText = Instantiate (textPrefab) as Text;
		storyText.text = text;

		switch (currentMood)
		{
			case "shout":
				storyText.fontSize = storyText.fontSize + 2;
				break;
			case "right":
				storyText.color = Color.green;
				break;
			case "wrong":
				storyText.color = Color.red;
				break;
			case "neutral":
				storyText.color = Color.white;
				break;
			case "blank": // allows for blank lines
				storyText.color = Color.clear;
				break;

		}
		storyText.transform.SetParent (currentRole == "teacher" ? leftCanvas.transform : rightCanvas.transform, false);
	}

	// Creates a button showing the choice text
	Button CreateChoiceView (string text) {
		// Creates the button from a prefab
		Button choice = Instantiate (buttonPrefab) as Button;
		choice.transform.SetParent (currentRole == "teacher" ? leftCanvas.transform: rightCanvas.transform, false);
		
		// Gets the text from the button prefab
		Text choiceText = choice.GetComponentInChildren<Text> ();
		choiceText.text = text;

		// Make the button expand to fit the text
		// HorizontalLayoutGroup layoutGroup = choice.GetComponent <HorizontalLayoutGroup> ();
		// layoutGroup.childForceExpandHeight = false;

		return choice;
	}

	// Destroys all the children of this gameobject (all the UI)
	void RemoveChildrenLeft () {
		int childCount = leftCanvas.transform.childCount;
		for (int i = childCount - 1; i >= 0; --i) {
			GameObject.Destroy (leftCanvas.transform.GetChild (i).gameObject);
		}
	}

	void RemoveChildrenRight()
	{
		int childCount = rightCanvas.transform.childCount;
		for (int i = childCount - 1; i >= 0; --i)
		{
			GameObject.Destroy(rightCanvas.transform.GetChild(i).gameObject);
		}
	}

	void RemoveChildrenAnswer()
	{
		int childCount = answerCanvas.transform.childCount;
		for (int i = childCount - 1; i >= 0; --i)
		{
			GameObject.Destroy(answerCanvas.transform.GetChild(i).gameObject);
		}
	}

	public void onSubmitName(string value)
    {
		username = value;
		RemoveChildrenLeft();
		RemoveChildrenRight();
		Text usernamePrompt = Instantiate(textPrefab) as Text;
		usernamePrompt.text = $"Welcome to the quiz {username}!";
		usernamePrompt.transform.SetParent(leftCanvas.transform, false);
		StartStory();
	}

}
