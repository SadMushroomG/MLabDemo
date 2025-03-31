using TMPro;
using UnityEngine;

public class ExpBar : MonoBehaviour
{
    [Header("Health Settings")]
    [SerializeField] private int curExpLevel = 1;
    [SerializeField] private float maxExp = 100f;
    [SerializeField] private float currentExp = 100f;

    [Header("Visual Settings")]
    [SerializeField] private SpriteRenderer expBarImage;
    [SerializeField] private Gradient expGradient;

    [Header("UI Settings")]
    [SerializeField] private TMP_Text expText;
    [SerializeField] private float fillSpeed = 5f;

    [Header("Damage Settings")]
    [SerializeField] private float damageAmount = 10f;

    private float targetFillAmount;
    private float currentFillAmount;

    private float originSriteRendererWidth;
    private void Awake()
    {
    }

    // Start is called before the first frame update
    void Start()
    {
        if (expBarImage == null)
        {
            expBarImage = GetComponent<SpriteRenderer>();
            if (expBarImage == null)
            {
                Debug.LogError("ExpBar: No Image component found!");
                return;
            }
        }

        originSriteRendererWidth = expBarImage.transform.localScale.x;
        // 初始化血条
        UpdateExpBarImmediate(currentExp);
    }

    // Update is called once per frame
    void Update()
    {
        // 平滑过渡到目标填充量
        if (currentFillAmount != targetFillAmount)
        {
            currentFillAmount = Mathf.Lerp(currentFillAmount, targetFillAmount, GameMain.deltaTime * fillSpeed);
            expBarImage.transform.localScale = new Vector3(currentFillAmount * originSriteRendererWidth, expBarImage.transform.localScale.y, expBarImage.transform.localScale.z);
        }
    }

    public void UpdateExpBarImmediate(float exp)
    {
        currentExp = Mathf.Clamp(exp, 0f, maxExp);
        targetFillAmount = currentExp / maxExp;
        expBarImage.color = expGradient.Evaluate(targetFillAmount);

        currentFillAmount = targetFillAmount;
        expBarImage.transform.localScale = new Vector3(currentFillAmount * originSriteRendererWidth, expBarImage.transform.localScale.y, expBarImage.transform.localScale.z);
            // 更新文本
        if (expText != null)
        {
            expText.text = curExpLevel.ToString();
        }
    }

    public void UpdateExp(float exp)
    {
        currentExp = Mathf.Clamp(exp, 0f, maxExp);
        targetFillAmount = currentExp / maxExp;

        // 更新颜色
        expBarImage.color = expGradient.Evaluate(targetFillAmount);

        // 更新文本
        if (expText != null)
        {
            expText.text = curExpLevel.ToString();
        }
    }

    public void UpdateExpLevel(int nextLevel, float nextMaxExp)
    {
        curExpLevel = nextLevel;
        maxExp = nextMaxExp;
    }
    public void SetMaxExp(float max)
    {
        maxExp = max;
        UpdateExp(currentExp);
    }
}
