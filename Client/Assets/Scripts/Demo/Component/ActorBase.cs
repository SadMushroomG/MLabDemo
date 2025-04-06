using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.UIElements;

public class ActorBase : MonoBehaviour
{
    public MLabActorType actorType;

    [BoxGroup("生命")]
    [LabelText("血条显示")]
    public HealthBar healthBar;
    [BoxGroup("生命")]

    [LabelText("最大生命")]
    public float maxHealth = 100;
    [BoxGroup("生命")]

    [LabelText("当前生命")]
    public float currentHealth = 100; 

    
    [BoxGroup("经验")]
    [LabelText("经验条显示")]
    public ExpBar expBar;

    [BoxGroup("经验")]
    [LabelText("当前等级")]
    public int curExpLevel = 1;

    [BoxGroup("经验")]
    [LabelText("当前经验")]
    public float curExpValue = 0.0f;

    [BoxGroup("经验")]
    [LabelText("当前经验上限")]
    public float curExpMaxValue = 100.0f;

    [BoxGroup("经验")]
    [LabelText("提供经验值")]
    public float expValue = 1;

    [BoxGroup("攻击")]
    [LabelText("武器")]
    [SerializeField] public List<WeaponBase> weapons;

    [BoxGroup("动画")]
    [LabelText("使用动画")]
    [SerializeField] protected bool useAnimation = false;

    [BoxGroup("动画")]
    [LabelText("攻击动画触发器")]
    [SerializeField] protected string attackAnimationTrigger = "Attack";

    protected Animator animator;
    protected Transform targetTransform;
    protected ActorBase lastAttackedActor;

    [BoxGroup("动画")]
    [LabelText("展示节点Root")]
    public Transform showNodeRoot;

    [BoxGroup("动画")]
    [LabelText("Sprite初始向右")]
    public bool initDirRight;
    private int lastScale = 0;

    [BoxGroup("动画")]
    [LabelText("动态切换面向")]
    public bool faceTarget = true;
    private Vector3 lastPosisiton;

    public bool IsAttackedThisFrame()
    {
        for (int i = 0; i < weapons.Count; i++)
        {
            if (weapons[i].attacked)
            {
                return true;
            }
        }
        return false;
    }

    public virtual void Awake()
    {
        currentHealth = maxHealth;
        if (healthBar != null)
        {
            healthBar.SetMaxHealth(maxHealth);
            // healthBar.UpdateHealthBarImmediate(currentHealth);
        }
        
        if (expBar != null)
        {
            expBar.UpdateExpLevel(curExpLevel, curExpMaxValue);
            // expBar.UpdateExpBarImmediate(curExpValue);
        }

        for (int i = 0; i < weapons.Count; i++)
        {
            WeaponBase weapon = weapons[i];
            if (weapon != null)
            {
                weapon.SetOwner(this);
            }
        }

        if (useAnimation)
        {
            animator = GetComponent<Animator>();
        }
    }

    #region 伤害
    public void TakeDamage(float damage)
    {
        currentHealth -= damage;
        healthBar.UpdateHealth(currentHealth);
    }
    #endregion

    //TOFix:连升多级的情况
    public virtual void GetExp(float exp)
    {
        MLabUtils.DebugLog(this.name + " GetExp: " + exp);
        curExpValue += exp;
        if (curExpValue >= curExpMaxValue)
        {
            curExpLevel++;
            curExpValue -= curExpMaxValue;
            curExpMaxValue *= 2;
            expBar.UpdateExpLevel(curExpLevel, curExpMaxValue);
        }
        if(expBar != null)
        {
            expBar.UpdateExp(curExpValue);
        }
    }

    public virtual void SetLastAttackedActor(ActorBase actor)
    {
        lastAttackedActor = actor;
    }

    protected virtual void Update()
    {
        if (faceTarget && showNodeRoot != null && transform.position != lastPosisiton)
        {
            var dir = (transform.position - lastPosisiton).normalized;
            var scaleX = dir.x > 0 ? 1 : -1;
            if (scaleX != lastScale)
            {
                var originScale = showNodeRoot.localScale;
                showNodeRoot.transform.localScale = new Vector3((initDirRight ? 1 : -1) * scaleX * Mathf.Abs(originScale.x), originScale.y, originScale.z);
                Debug.Log(gameObject.name + " Switch X Scale");
                lastScale = scaleX;
            }
            lastPosisiton = transform.position;
        }
    }
}
