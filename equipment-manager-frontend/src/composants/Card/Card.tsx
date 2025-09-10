type card ={
    title: number;
    subTitle: string;
    icon: string;
}

type cardProps ={
    card: card[];
}
export default function Card( {card}:cardProps) {
  return (
    <div className='card'>
        {card.map((c, index) =>(
            <div key={index} className="card__body" >
                <div className="card__text">
                    <h2 className="card__title">{c.title}</h2>
                    <p className="card__subtitle">{c.subTitle}</p>
                </div>
                <div
                    className="card__icon"
                    style={{ backgroundImage: `url(${c.icon})` }}
                />
            </div>
        ))}
    </div>
  )
}
