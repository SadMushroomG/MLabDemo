using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum MLabProgressBarType
{
    Slide,
    Circle,
}
public class ProgressBarComponent : MonoBehaviour
{
    public MLabProgressBarType progressBarType;

    public float Progress
    {
        get { return progress; }
        set
        {
            value = Mathf.Clamp01(value);
            if (progress != value)
            {
                progress = value;
                SetProgress(progress);
            }
        }
    }
    private float progress = 0;
    public SpriteRenderer spriteRenderer;

    private Material material;
    protected void Awake()
    {
        if (spriteRenderer == null)
        {
            return;
        }

        material = new Material(spriteRenderer.sharedMaterial);
        spriteRenderer.material = material;
    }

    private void SetProgress(float progress)
    { 
        material.SetFloat("_Progress", progress);
    }

}
