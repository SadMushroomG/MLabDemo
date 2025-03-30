using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class HealthBar : MonoBehaviour
{
    [Header("Health Settings")]
    [SerializeField] private float maxHealth = 100f;
    [SerializeField] private float currentHealth = 100f;

    [Header("Visual Settings")]
    [SerializeField] private SpriteRenderer healthBarImage;
    [SerializeField] private Gradient healthGradient;

    [Header("UI Settings")]
    [SerializeField] private TMP_Text healthText;
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
        if (healthBarImage == null)
        {
            healthBarImage = GetComponent<SpriteRenderer>();
            if (healthBarImage == null)
            {
                Debug.LogError("HealthBar: No Image component found!");
                return;
            }
        }

        originSriteRendererWidth = healthBarImage.transform.localScale.x;
        // 初始化血条
        UpdateHealthBarImmediate(maxHealth);
    }

    // Update is called once per frame
    void Update()
    {
        // 平滑过渡到目标填充量
        if (currentFillAmount != targetFillAmount)
        {
            currentFillAmount = Mathf.Lerp(currentFillAmount, targetFillAmount, GameMain.deltaTime * fillSpeed);
            healthBarImage.transform.localScale = new Vector3(currentFillAmount * originSriteRendererWidth, healthBarImage.transform.localScale.y, healthBarImage.transform.localScale.z);
        }
    }

    public void UpdateHealthBarImmediate(float health)
    {
        currentHealth = Mathf.Clamp(health, 0f, maxHealth);
        targetFillAmount = currentHealth / maxHealth;
        healthBarImage.color = healthGradient.Evaluate(targetFillAmount);

        currentFillAmount = targetFillAmount;
        healthBarImage.transform.localScale = new Vector3(currentFillAmount * originSriteRendererWidth, healthBarImage.transform.localScale.y, healthBarImage.transform.localScale.z);
    }

    public void UpdateHealth(float health)
    {
        currentHealth = Mathf.Clamp(health, 0f, maxHealth);
        targetFillAmount = currentHealth / maxHealth;

        // 更新颜色
        healthBarImage.color = healthGradient.Evaluate(targetFillAmount);

        // 更新文本
        if (healthText != null)
        {
            healthText.text = $"{Mathf.Round(currentHealth)} / {maxHealth}";
        }
    }

    public void SetMaxHealth(float max)
    {
        maxHealth = max;
        // UpdateHealth(currentHealth);
    }
}
