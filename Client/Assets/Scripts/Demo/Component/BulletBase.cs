using UnityEngine;

public class BulletBase : MonoBehaviour
{
    public MLabActorType actorType;
    public MLabActorType targetType;

    protected WeaponBase Weapon;
    public GameObject target;
    public Vector3 velocity;
    public float speed;
    public float bulletDamage;
    public float lifetime = 5f; // Bullet will be destroyed after 5 seconds

    public virtual void Initialize(GameObject target, float spd, float dmg, MLabActorType actorType, WeaponBase weapon)
    {
        this.target = target;
        speed = spd;
        bulletDamage = dmg;
        this.actorType = actorType;
        this.Weapon = weapon;
        targetType = GameMain.Instance.GetTargeType(actorType);
    }

    public virtual void Initialize(Vector3 target, float spd, float dmg, MLabActorType actorType, WeaponBase weapon)
    {
        this.velocity = (target - transform.position).normalized * spd;
        speed = spd;
        bulletDamage = dmg;
        this.actorType = actorType;
        this.Weapon = weapon;
        targetType = GameMain.Instance.GetTargeType(actorType);
    }

    private void Update()
    {
        UpdateBehaviour();
    }

    public virtual void UpdateBehaviour()
    {
        if (target != null && target.transform != null)
        {
            // Move the bullet
            Vector3 direction = target.transform.position - transform.position;
            transform.position += direction.normalized * speed * GameMain.deltaTime;

            // Destroy bullet after lifetime
            lifetime -= GameMain.deltaTime;
            if (lifetime <= 0)
            {
                Destroy(gameObject);
            }
        }
        else if(velocity != Vector3.zero)
        {
            // Move the bullet
            transform.position += velocity * GameMain.deltaTime;
            lifetime -= GameMain.deltaTime;
            if (lifetime <= 0)
            {
                Destroy(gameObject);
            }
        }

    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        OnBulletHit(other);
    }

    public virtual void OnBulletHit(Collider2D other)
    {
        // Check if the hit object has a health component
        var actor = other.GetComponent<ActorBase>();
        if (actor != null && actor.actorType == targetType)
        {
            // Deal damage
            //DamageCalculator.Instance.CalculateDamage(this, target.GetComponent<ActorBase>());
            actor.TakeDamage(Weapon.GetDamage(out bool isCrit));
            actor.SetLastAttackedActor(GetComponentInParent<WeaponBase>()?.GetOwner());
            JumpWordHelper.Instance.GenerateJumpWord(actorType, ((int)bulletDamage).ToString(), actor.transform.position + Vector3.up * 0.5f, isCrit);
            //看是不是只能造成一次伤害的武器发出的子弹
            if (Weapon.OnBulletHit(this))
            {
                Destroy(gameObject);
            }
        }
    }
}