using UnityEngine;

public class BulletBase : MonoBehaviour
{
    public MLabActorType actorType;
    public MLabActorType targetType;

    private WeaponBase Weapon;
    protected GameObject target;
    protected float speed;
    private float bulletDamage;
    protected float lifetime = 5f; // Bullet will be destroyed after 5 seconds

    public virtual void Initialize(GameObject target, float spd, float dmg, MLabActorType actorType, WeaponBase weapon)
    {
        this.target = target;
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
        if (target == null || target.transform == null)
        {
            Destroy(gameObject);
            return;
        }
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
            actor.TakeDamage(bulletDamage);
            actor.SetLastAttackedActor(GetComponentInParent<WeaponBase>()?.GetOwner());
            Weapon.OnBulletHit(this);
            JumpWordHelper.Instance.GenerateJumpWord(actorType, bulletDamage.ToString(), actor.transform.position + Vector3.up * 0.5f);
            Destroy(gameObject);
        }
    }
}