using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net;
using System.IO;
using System;
using UnityEngine.Networking;
using System.Text;

public class APIController : MonoBehaviour
{
    //[SerializeField] List<Score> scores;
    // Start is called before the first frame update
    [SerializeField] Score[] scores;
    [SerializeField] GameObject entryPrefab;
    [SerializeField] Transform scorePanel;
    void Start()
    {
        
    }

    // Update is called once per frame
    public void PostScore()
    {
        string json = JsonUtility.ToJson(new Score("Melissa", 114));
        string token = "Bearer ksdhf;lsajdfjaldfjlkasjdflkja;ldfj;lajs;ldfjlasdjfl;";
        Debug.Log(json);
        StartCoroutine(Post("https://leaderboards.simpleapi.dev/api/scores", json, token));
    }
    public void getScores()
    {
        // need to implement using...
        // need to implement using...
        HttpWebRequest request = (HttpWebRequest) WebRequest.Create("https://leaderboards.simpleapi.dev/api/scores");
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        StreamReader reader = new StreamReader(response.GetResponseStream());
        string json = reader.ReadToEnd();
        RootObject rootObject = JsonUtility.FromJson<RootObject>("{\"scoreData\":" + json + "}");
        scores = rootObject.scoreData;
        // need to empty the children inside the scorePanel
        foreach (Transform child in scorePanel)
        {
            Destroy(child.gameObject);
        }
        for (int x = 0; x < scores.Length; x++)
        {
            GameObject entry = Instantiate(entryPrefab, scorePanel);
            entry.GetComponent<Entry>().playerName.text = scores[x].name;
            entry.GetComponent<Entry>().playerScore.text = $"{scores[x].score}"; ;
        }

    }

    IEnumerator Post(string url, string bodyJsonString, string token)
    {
        // better memory mgmt with using
        using (UnityWebRequest request = UnityWebRequest.Post(url, "POST"))
        {
            //var request = new UnityWebRequest(url, "POST");
            byte[] bodyRaw = Encoding.UTF8.GetBytes(bodyJsonString);
            request.uploadHandler = (UploadHandler)new UploadHandlerRaw(bodyRaw);
            request.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
            request.SetRequestHeader("Content-Type", "application/json");
            request.SetRequestHeader("Authorization", token);
            yield return request.SendWebRequest();
            Debug.Log("Status Code: " + request.responseCode);

        }
    }
}

[Serializable]
class Score
{
    public string name;
    public int score;

    public Score(string _name, int _score)
    {
        name = _name;
        score = _score;
    }
}

[Serializable]
class RootObject
{
    public Score[] scoreData;
}
